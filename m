Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWCMIki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWCMIki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWCMIki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:40:38 -0500
Received: from fmr20.intel.com ([134.134.136.19]:43910 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932354AbWCMIkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:40:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Mon, 13 Mar 2006 16:35:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B2DB21B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZGcDDWnWpt+GReRyCvv9jPcFrLbwACDwMA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       <v4l-dvb-maintainer@linuxtv.org>, <video4linux-list@redhat.com>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       <linux-input@atrey.karlin.mff.cuni.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 13 Mar 2006 08:38:53.0264 (UTC) FILETIME=[8F1C9500:01C64679]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your debug information.

>
>> Could you try to mute thermal poll?
>
>Done.  The sleep.sh script now has
>
>echo 0 > /proc/acpi/thermal_zone/THM2/polling_frequency
>echo 0 > /proc/acpi/thermal_zone/THM0/polling_frequency
>sleep 1

Hmm,  could you file dmesges with tmermal module loaded and
unloaded?

>
>> I need the full log  for S3 suspend failure not just snippets.
>> Please attach it on bugzilla.kernel.org
>
>Done.

I saw this acpi_debug=0xffffffff.

I used to used to use acpi_debug_layer=0x10 acpi_debug_level=0x10
Could you try that?

