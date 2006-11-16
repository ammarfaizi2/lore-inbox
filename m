Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424043AbWKPNd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424043AbWKPNd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933221AbWKPNd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:33:57 -0500
Received: from spirit.analogic.com ([204.178.40.4]:6162 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932861AbWKPNd5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:33:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 16 Nov 2006 13:33:55.0819 (UTC) FILETIME=[DD1A1BB0:01C70983]
Content-class: urn:content-classes:message
Subject: Re: Initial ramdisk support does not work (for me) on 2.6.17.13
Date: Thu, 16 Nov 2006 08:33:55 -0500
Message-ID: <Pine.LNX.4.61.0611160830210.20332@chaos.analogic.com>
In-Reply-To: <E1Gkgqc-0003F3-6u@flower>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Initial ramdisk support does not work (for me) on 2.6.17.13
thread-index: AccJg9050fLUIqetTk+mM5yUrY+cLQ==
References: <455AF068.5020700@meinberg.de> <E1Gkgqc-0003F3-6u@flower>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Heiko Gerstung" <heiko.gerstung@meinberg.de>
Cc: "Oleg Verych" <olecom@flower.upol.cz>,
       "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Hi!
>
> Hallo.
>
> We are building embedded devices based on Linux and we use a ramdisk as
> our root device in order to avoid problems with people switching off the
> unit without a proper shutdown and to save write-cycles on our flash disc.
>
> Using a 2.6.12 kernel it was no problem to boot the system by using this
> kernel parameters:
> load_ramdisk=1 console=tty0 initrd=initrd.gz rw  vga=769
> ramdisk_size=32768 root=/dev/ram0
>
> Today I tried to test run a 2.6.17.12 kernel using the same parameters
> but I get this error message:
> VFS: Cannot open root device "ram0" or unknown-block(1,0)
> Please append a correct "root=" boot option
>
This is the message you get if you accidentally build the kernel without
ramdisk support. Check your configuration.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
