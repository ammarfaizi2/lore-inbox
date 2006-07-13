Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWGMHmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWGMHmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWGMHmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:42:24 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:55257 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751499AbWGMHmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:42:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Expertise required on building code for SMP
Date: Thu, 13 Jul 2006 13:12:14 +0530
Message-ID: <24ED22E506B5A042BF5B05B6B017D86C0A9046@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Expertise required on building code for SMP
Thread-Index: AcamT9tv6U48k1m+SL2Oru5fPPbY0w==
From: <bhuvan.kumarmital@wipro.com>
To: <linux-usb-devel@lists.sourceforge.net>,
       <kernelnewbies-request@nl.linux.org>, <kernel-mentors@selenic.com>,
       <os_drivers@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jul 2006 07:42:14.0788 (UTC) FILETIME=[DBDBCC40:01C6A64F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've written a device driver in linux for a pcmcia card with usb and
serial functionality. I need to test this driver on a dual core/SMP
machine. We work on kernel 2.6.15.4. I have recompiled this kernel
version on my dual core machine with the CONFIG_SMP flag set during
menuconfig.

How do i ensure that my driver is making use of the SMP feature? Do
build my driver code i have a makefile in which i use the EXTRA_CFLAGS=
-D__SMP__ -DCONFIG_SMP -DLINUX.
Am i using the right flags? Do these flags really have any significance
in deciding whether the SMP capability will be exploited? Are there any
other flags i need to use while building my driver code? What does the
-jN flag mean? Should i be using it in my case.

Please guide me. I am a bit confused.
 
Regards
 
Bhuvan Mital
Project Engineer, 
Wipro Technologies
