Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291465AbSBMJ1n>; Wed, 13 Feb 2002 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291466AbSBMJ1d>; Wed, 13 Feb 2002 04:27:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43526 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291465AbSBMJ1Z>; Wed, 13 Feb 2002 04:27:25 -0500
Subject: Re: [patch] printk and dma_addr_t
To: akpm@zip.com.au (Andrew Morton)
Date: Wed, 13 Feb 2002 09:40:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml), ralf@uni-koblenz.de (Ralf Baechle)
In-Reply-To: <3C6A2FCA.C4F49062@zip.com.au> from "Andrew Morton" at Feb 13, 2002 01:20:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16avu8-0004lh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dma_addr_t type.   So the above usage will become
> 
> 	printk("stuff: " DMA_ADDR_T_FMT " %s", a, s);

Vomit. How about adding a dma_addr_t %code to the printk function ?
