Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285910AbRLHLQU>; Sat, 8 Dec 2001 06:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285909AbRLHLQK>; Sat, 8 Dec 2001 06:16:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37637 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285912AbRLHLQD>; Sat, 8 Dec 2001 06:16:03 -0500
Subject: Re: Linux 2.4.17-pre6
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sat, 8 Dec 2001 11:25:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <3C116B1E.9C153277@eyal.emu.id.au> from "Eyal Lebedinsky" at Dec 08, 2001 12:21:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CfbO-00017G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /lib/modules/2.4.17-pre6/kernel/drivers/char/drm/sis.o
> depmod:         sis_malloc_Ra3329ed5
> depmod:         sis_free_Rced25333

Ok I'll look at that one. I think you need to include sis frame buffer
support. If so thats a dependancy I don't think I can fix in CML1
