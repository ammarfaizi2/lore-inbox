Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270269AbRHRRtb>; Sat, 18 Aug 2001 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270266AbRHRRtW>; Sat, 18 Aug 2001 13:49:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:34946 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S270280AbRHRRtK>; Sat, 18 Aug 2001 13:49:10 -0400
Date: Sat, 18 Aug 2001 13:49:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108181749.f7IHnPe27413@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 locks up solidly with USB and SMP
In-Reply-To: <mailman.998111498.32209.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.998111498.32209.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With kernel version 2.4.9, my system locks up solidly when I run with SMP 
> enabled and attempt to print anything to my USB printer.   I have seen 
> this behavior for the last few kernel revs.

Try to convert lockup into oops. Sometimes slab poisoning helps.

> I have usbcore and usb-uhci loaded as modules.

Well, someone will undoubtedly suggest to try JE uhci, do that too.

-- Pete
