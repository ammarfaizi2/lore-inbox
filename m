Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161333AbWATFo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWATFo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWATFo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:44:59 -0500
Received: from fmr13.intel.com ([192.55.52.67]:28645 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161333AbWATFo7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:44:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16-rc1-mm1 usb hub problems
Date: Fri, 20 Jan 2006 00:29:15 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEDA@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc1-mm1 usb hub problems
Thread-Index: AcYcfG4okgEByeo2RA6Ts2BpynNTfgBBTqWg
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jan 2006 05:29:22.0195 (UTC) FILETIME=[77F22630:01C61D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> When I boot -mm1 in docking station, I get problems. First is ugly
>> warning near yenta:

When is the last time this worked?

The ACPI git patch has not changed since 2.6.15-mm1,
so if it worked there, then the failure was provoked
by some other change.

If you can test the ACPI patch in isolation, that may help.
You can snag it from here to test it without other mm changes:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/

Presently the latest is against vanilla 2.6.15, but a 2.6.16-rc1
patch should be coming out shortly.

thanks,
-Len




 
