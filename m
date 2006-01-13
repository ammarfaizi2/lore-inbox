Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWAMMru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWAMMru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWAMMrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:47:49 -0500
Received: from spirit.analogic.com ([204.178.40.4]:44550 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1422650AbWAMMrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:47:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <62439.61.247.248.51.1137144158.squirrel@66.98.166.28>
X-OriginalArrivalTime: 13 Jan 2006 12:47:47.0512 (UTC) FILETIME=[8E3EBB80:01C6183F]
Content-class: urn:content-classes:message
Subject: Re: REG:problem i am facing
Date: Fri, 13 Jan 2006 07:47:42 -0500
Message-ID: <Pine.LNX.4.61.0601130745020.7579@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: REG:problem i am facing
Thread-Index: AcYYP45lYrdcMRz/S2Skvt1Val6VeA==
References: <62439.61.247.248.51.1137144158.squirrel@66.98.166.28>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <balamurugan@sahasrasolutions.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006 balamurugan@sahasrasolutions.com wrote:

> Dear all,
>
> i am compiling kernel-2.4.32 with i386 processor with wirless lan and all
> other facilites, it will compaile in make ,make dep, make menuconfig but i
> going to intall with make install, the initrd is missing the following
> error is displayed , please help on this issue.
>
> warning: kernel is too big for standalone boot from floppy
> sh -x ./install.sh 2.4.32 bzImage /bala/linux-2.4.32/System.map ""
> + '[' -x /root/bin/installkernel ']'
> + '[' -x /sbin/installkernel ']'
> + exec /sbin/installkernel 2.4.32 bzImage /bala/linux-2.4.32/System.map ''
> depmod: Can't open /lib/modules/2.4.32/modules.dep for writing
> /lib/modules/2.4.32 is not a directory.
> mkinitrd failed


Yes. No modules directory for this kernel version...

> make[1]: *** [install] Error 1
> make[1]: Leaving directory `/bala/linux-2.4.32/arch/i386/boot'
> make: *** [install] Error 2
>
> the issue is very urgent , u please clear the doute asap .
>
> thanks & regards
> balamurugan.j
>

For linux-2.4.x, you need ....

`make`
`make modules`
`make modules_install`
`make install`

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
