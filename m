Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRFBQSE>; Sat, 2 Jun 2001 12:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262610AbRFBQRz>; Sat, 2 Jun 2001 12:17:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21519 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262609AbRFBQRl>; Sat, 2 Jun 2001 12:17:41 -0400
Subject: Re: CUV4X-D lockup on boot
To: lk@mailandnews.com
Date: Sat, 2 Jun 2001 17:15:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m31yp3qlt5.fsf@fork.man2.dom> from "lk@mailandnews.com" at Jun 02, 2001 10:21:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156E44-0001sS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an ASUS CUV4X-D Dual Processor Mainboard based on a VIA
> 694XDP chipset. I notice from the archives that someone else
> has also reported a lockup with the m/b when using two cpus
> and have some info that may be useful to track it down.
> 
> Using kernel 2.4.5 the kernel locks up sporadically at boot
> time. When I enable the NMI watchdog it occasionally gets
> enabled prior to the lockup and perhaps can be useful for
> debugging the problem. Here's what happens:

At minimum you need the 1007 bios and to run noapic. As yet we don't know why
or what the newer BIOS has done to make it boot at all


