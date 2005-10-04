Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVJDTJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVJDTJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVJDTJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:09:40 -0400
Received: from spirit.analogic.com ([204.178.40.4]:61966 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964925AbVJDTJj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:09:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051004185520.9489.qmail@web35905.mail.mud.yahoo.com>
References: <20051004185520.9489.qmail@web35905.mail.mud.yahoo.com>
X-OriginalArrivalTime: 04 Oct 2005 19:09:38.0266 (UTC) FILETIME=[2A659BA0:01C5C917]
Content-class: urn:content-classes:message
Subject: Re: error during compiling the kernel 2.6.10 on FC3 
Date: Tue, 4 Oct 2005 15:09:38 -0400
Message-ID: <Pine.LNX.4.61.0510041506100.30366@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error during compiling the kernel 2.6.10 on FC3 
Thread-Index: AcXJFyqHD++b2bwsSm2S022dZmVJqA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "umesh chandak" <chandak_pict@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, umesh chandak wrote:

> hi ,
>    I am compiling kernel 2.6.10 on FC3 as usual
> using following steps
>
> 1) make Menuconfig
> 2) make bzImage
> 3) make modules
>           These 3 steps work properly.
> 4) make modules_install
>
>        But in 4 th step i got error after some moules
>
> are installed
>
> Error Message  is like this
> if [ -r System.map ]; then /sbin/depmod -ae -F
> System.map  2.6.10; fi /bin/sh: line 1: 11366
> Terminated              /sbin/depmod -ae -F System.map
> 2.6.10
> make: *** [_modinst_post] Error 143
>
> Due to this error initrd is not made in step
> 5) make install
>
>     I also want to know what  Error 143 indicates.
>
> What should i do. How to overcome this error
>
>              Thanks in advance

Install new Module-Init-tools package as shown in
../linux-`uname -r`/Documentation/Changes...

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
