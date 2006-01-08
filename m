Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbWAHIQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWAHIQn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWAHIQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:16:43 -0500
Received: from fmr13.intel.com ([192.55.52.67]:45775 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030533AbWAHIQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:16:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 03:16:29 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348A@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.15-mm2
Thread-Index: AcYTwX1m9nmdlNg8QSe/ZPjZ/esWrgAafRzg
From: "Brown, Len" <len.brown@intel.com>
To: "Brice Goglin" <Brice.Goglin@ens-lyon.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2006 08:16:31.0785 (UTC) FILETIME=[D5172190:01C6142B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>git-acpi. I tried to revert it but there are lots of other patches
>depending on it, so I finally gave up.

Brice,
Can you try the converse?
Apply the acpi patch (which is included in -mm)
without the rest of the mm tree to see if that broke acpi-cpufreq?:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/acpi-test-20051216-2.6.15.diff.bz2

thanks,
-Len
