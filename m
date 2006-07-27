Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWG0XUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWG0XUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWG0XUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:20:15 -0400
Received: from mga08.intel.com ([134.134.136.24]:4403 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750772AbWG0XUN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:20:13 -0400
X-IronPort-AV: i="4.07,190,1151910000"; 
   d="scan'208"; a="97233623:sNHT18975390"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Generic battery interface
Date: Thu, 27 Jul 2006 19:20:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Generic battery interface
Thread-Index: Acaxymwgkuz1JAGuQnqIzfX441zZiAABvINQ
From: "Brown, Len" <len.brown@intel.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Shem Multinymous" <multinymous@gmail.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, <vojtech@suse.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 23:20:10.0819 (UTC) FILETIME=[34C52930:01C6B1D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Anyone volunteers write battery layer? If so, I'd go with /dev/XXX,

I'd like to take a swing at it.
If it catches on, I'd be happy to maintain it.

I think we should be able to make different underlying battery
instrumentation make sense to user-space -- even Zaurus-style systems.

I'm not religious about /dev vs. /sys.  At the end of the day I think
that an easy and consistent programming I/F between user and kernel
is the highest priority, and at the moment for this type of thing
I think /dev is simpler than /proc or /sys files.  But if using
/dev has some fatal flaw, I'll be happy to change to /sys.
Also, there is no law that says we can't do some of both
if that turns out to be useful.

-Len
