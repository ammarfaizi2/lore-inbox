Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbRE0V1u>; Sun, 27 May 2001 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262353AbRE0V1k>; Sun, 27 May 2001 17:27:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29710 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262345AbRE0V1f>; Sun, 27 May 2001 17:27:35 -0400
Subject: Re: 2.4.5-ac1 won't boot with 4GB bigmem option
To: fabio@chromium.com (Fabio Riccardi)
Date: Sun, 27 May 2001 22:25:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B116BAC.F45612F3@chromium.com> from "Fabio Riccardi" at May 27, 2001 02:03:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15482F-0002Mz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > mm: critical shortage of bounce buffers.
> 
> Indeed this message has been pestering me in all the recent .4-acx kernels when
> the machine is under heavy FS pressure.
> 
> In these kernels I observe a significative (5-10%) performance degradation as
> soon as the FS cache fills up all the available memory, at this moment "kswapd"

Its there to prove we had a problem

> 2.4.2-acx and early 2.4.3-acx kernles were much better in this respect and a lot
> more stable.

Hit any 2.4 kernel pre 2.4.5 vanilla [maybe fixed] and you will break bigmem
that way.
