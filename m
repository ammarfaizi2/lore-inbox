Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132722AbRDDAQs>; Tue, 3 Apr 2001 20:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132719AbRDDAQ2>; Tue, 3 Apr 2001 20:16:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132725AbRDDAQQ>; Tue, 3 Apr 2001 20:16:16 -0400
Subject: Re: memory size detection problem on 2.3.16+ and 2.4.x
To: michaelm@mjmm.org (Michael Miller)
Date: Wed, 4 Apr 2001 01:18:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104040003.f3403MG01149@mjmm.org> from "Michael Miller" at Apr 04, 2001 01:03:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kazw-0000o0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the bios will set the carry flag on the return from the call should
> there be an error.  However, the BIOS on my PC doesnt do this- infact
> it seems to simply return from the call without changing any registers.

Your BIOS is faulty. No new suprises.

>  meme801:
> +	xorl	%edx, %edx			# Clear regs to work around
> +	xorl	%ecx, %ecx			# flakey BIOSes which don't
> +						# use carry bit correctly
> +						# This way we get 0MB ram on
> +						# call failure

Wouldn't setting the carry flag be clearer ?



