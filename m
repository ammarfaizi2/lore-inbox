Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291630AbSBNNUT>; Thu, 14 Feb 2002 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291633AbSBNNUA>; Thu, 14 Feb 2002 08:20:00 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:26897 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S291630AbSBNNTk>;
	Thu, 14 Feb 2002 08:19:40 -0500
Message-ID: <3C6BB872.11A067BC@yahoo.com>
Date: Thu, 14 Feb 2002 08:15:30 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.20 i586)
MIME-Version: 1.0
To: Christoph Pittracher <pitt@gmx.at>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.20 RAM requirements
In-Reply-To: <E16b5w1-0006Js-00@the-village.bc.nu> <200202140144.50805@pitt4u.2y.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take a stab at this one - bet you are using zImage, and once
you try bzImage it will work.  Saw this just recently on a low
mem machine (LILO/loadlin) & haven't had a chance to investigate
further.

Please also report gcc/binutils etc. used.

Paul.

Christoph Pittracher wrote:
> 
> On Wednesday 13 February 2002 21:23, Alan Cox wrote:
> > > I wanted to boot kernel version 2.2.20 on my old Pentium 75Mhz
> > > system with 16MB RAM. After "uncompressing linux" i get a: "Out Of
> > > Memory -- System halted".
> > > Kernel version 2.2.19 works without problems (same kernel
> > > configuration). I didn't tried 2.4 kernels yet, but I wonder that
> > > 2.2.20 needs so much memory?
> > It doesn't. What boot loader are you using ?
> 
> LILO version 21.5-1 beta
> from Debian 2.2r5.

