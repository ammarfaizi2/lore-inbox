Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276096AbRI1Oxs>; Fri, 28 Sep 2001 10:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRI1Oxj>; Fri, 28 Sep 2001 10:53:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:263 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276090AbRI1Oxb>; Fri, 28 Sep 2001 10:53:31 -0400
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
To: jdthood@mail.com (Thomas Hood)
Date: Fri, 28 Sep 2001 15:58:04 +0100 (BST)
Cc: stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <3BB48C29.356901F1@mail.com> from "Thomas Hood" at Sep 28, 2001 10:41:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mz5Y-0007IZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In addition to applying the patch I just sent
> (thood-pnpbiosvaio-patch-20010928-3), you will have
> to move the definition of is_sony_vaio_laptop outside
> the #ifdefs in arch/i386/kernel/dmi_scan.c and i386_ksyms.c
> 
> You or Alan:  For the cleaned up patch, do we export this
> variable unconditionally?

I think so
