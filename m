Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266428AbRGONJD>; Sun, 15 Jul 2001 09:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbRGONIx>; Sun, 15 Jul 2001 09:08:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266428AbRGONIi>; Sun, 15 Jul 2001 09:08:38 -0400
Subject: Re: Linux 2.4.6-ac3 - some unresolved
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sun, 15 Jul 2001 14:09:28 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B50F26C.19334B5F@eyal.emu.id.au> from "Eyal Lebedinsky" at Jul 15, 2001 11:31:24 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LleK-0003z8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Building a kernel with as many modules as possible (i386).
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-ac3/kernel/drivers/net/dl2k.o

This one builds ok with gcc 2.96, but its a known problem with older
compilers and people are fixing

> depmod:         __ucmpdi2
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.6-ac3/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

This requires someone fixes comx to use the newer proc stuff

