Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281175AbRKLACZ>; Sun, 11 Nov 2001 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRKLACS>; Sun, 11 Nov 2001 19:02:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281175AbRKLACN>; Sun, 11 Nov 2001 19:02:13 -0500
Subject: Re: 2.4.15-pre3: missing functions
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Mon, 12 Nov 2001 00:09:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (list linux-kernel)
In-Reply-To: <3BEEF1CA.51423E2@eyal.emu.id.au> from "Eyal Lebedinsky" at Nov 12, 2001 08:46:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1634fG-0003xQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> depmod: *** Unresolved symbols in
> /lib/modules/2.4.15-pre3/kernel/drivers/md/lvm-mod.o
> depmod:         free_kiovec_sz
> depmod:         alloc_kiovec_sz
> 
> These are in a newer (in 2.4.13-ac8) fs/iobuf.c which has many changes
> relative to this (pre3) so a simple copy accross may be too drastic.

Thanks I'll sort that one out. It needs to drop back to using alloc_kiovec
and free_kiovec for the Linus tree

