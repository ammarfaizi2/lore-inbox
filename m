Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278771AbRJVMVJ>; Mon, 22 Oct 2001 08:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRJVMU7>; Mon, 22 Oct 2001 08:20:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277955AbRJVMUp>; Mon, 22 Oct 2001 08:20:45 -0400
Subject: Re: can't compile 2.4.12 with ac-5 patch
To: backes@rhrk.uni-kl.de
Date: Mon, 22 Oct 2001 13:27:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LINUX Kernel)
In-Reply-To: <XFMail.20011022140332.backes@rhrk.uni-kl.de> from "Joachim Backes" at Oct 22, 2001 02:03:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15veB7-0001nJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel/kernel.o(__ksymtab+0x9d8): undefined reference to `request_dma'
> kernel/kernel.o(__ksymtab+0x9e0): undefined reference to `free_dma'
> kernel/kernel.o(__ksymtab+0x9e8): undefined reference to `dma_spin_lock'
> fs/fs.o: In function `dma_read_proc':
> fs/fs.o(.text+0x1e76e): undefined reference to `get_dma_list'

Remember to "make oldconfig"
