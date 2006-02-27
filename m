Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWB0JGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWB0JGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWB0JGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:06:08 -0500
Received: from fmr18.intel.com ([134.134.136.17]:49128 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751705AbWB0JGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:06:05 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions
Date: Mon, 27 Feb 2006 17:04:15 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B0CE273@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions
Thread-Index: AcY7ZS1Trk11XljdTCOAEO19/ySC6AAFnnSw
From: "Yu, Luming" <luming.yu@intel.com>
To: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Tom Seeley" <redhat@tomseeley.co.uk>, "Dave Jones" <davej@redhat.com>,
       "Jiri Slaby" <jirislaby@gmail.com>, <michael@mihu.de>,
       <mchehab@infradead.org>, <v4l-dvb-maintainer@linuxtv.org>,
       <video4linux-list@redhat.com>, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       <linux-input@atrey.karlin.mff.cuni.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 27 Feb 2006 09:04:16.0724 (UTC) FILETIME=[C961A140:01C63B7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject    : S3 sleep hangs the second time - 600X
>References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
>Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
>Handled-By : Luming Yu <luming.yu@intel.com>
>Status     : is being debugged,
>             we might want to change the default back for 2.6.16:
>             http://lkml.org/lkml/2006/2/25/101
>

Accordint to bug report, the BIOS DSDT is modified.
I don't know how these changes affect the results
of suspend/resume. But, it is clear this is NOT right approach 
to fix problem. Hence, I need the testing report with 
un-modified DSDT on TP 600X, bios 1.11.

--Luming

