Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130502AbQJ0VMy>; Fri, 27 Oct 2000 17:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQJ0VMp>; Fri, 27 Oct 2000 17:12:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28789 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130502AbQJ0VM0>; Fri, 27 Oct 2000 17:12:26 -0400
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 27 Oct 2000 22:12:47 +0100 (BST)
Cc: pavel@suse.cz (Pavel Machek), torvalds@transmeta.com (Linus Torvalds),
        andrewm@uow.edu.au (Andrew Morton),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <39F9E849.D799D4A5@mandrakesoft.com> from "Jeff Garzik" at Oct 27, 2000 04:40:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pGnv-0004rv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pavel Machek wrote:
> > Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
> > reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).
> 
> What fails, when you use egcs-1.1.2 to build 2.0.x or early 2.2.x?

egcs miscompiles inlined strstr. It gets combined with bad asm constraints
to mean that 2.0 and earlier 2.2 will crash when fed the right (wrong ?) 
sequence of FPU ops to software emulate


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
