Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129836AbRBWTEn>; Fri, 23 Feb 2001 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbRBWTEX>; Fri, 23 Feb 2001 14:04:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63756 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129836AbRBWTER>; Fri, 23 Feb 2001 14:04:17 -0500
Subject: Re: 3c509 + sb16 bug
To: jjs@toyota.com (J Sloan)
Date: Fri, 23 Feb 2001 19:07:09 +0000 (GMT)
Cc: sjthorne@ozemail.com.au (Steve),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3A96B395.5124FFC1@toyota.com> from "J Sloan" at Feb 23, 2001 11:01:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WNYd-0006tS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps it's cold comfort, but I found long ago that
> 3c509 and SB don't mix too well, at least in Linux.

I've had them mixed ok before

> ISA devices are somewhat dumb, switching one
> of the cards for a PCI version does the trick here.

I think the problem here thought isnt the 3c509 and SB card, its the kernel
plug and play code. You might want to try building kernels with no PnP support
at all and see how they behave
