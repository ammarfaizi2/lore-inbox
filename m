Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274653AbRJTWCj>; Sat, 20 Oct 2001 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274669AbRJTWC3>; Sat, 20 Oct 2001 18:02:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4363 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274653AbRJTWCO>; Sat, 20 Oct 2001 18:02:14 -0400
Subject: Re: Non-GPL modules
To: md@uklinux.net (Martin Donnelly)
Date: Sat, 20 Oct 2001 23:08:19 +0100 (BST)
Cc: mrbrown@0xd6.org (M. R. Brown),
        root@chaos.analogic.com (Richard B. Johnson),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <1003415874.4004.45.camel@inchgower> from "Martin Donnelly" at Oct 18, 2001 03:37:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15v4Hz-0002W6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps a less blunt tool could be used to encourage people to release
> GPL compatibly licensed code for their previously binary modules? I
> think you risk manufacturers withdrawing the support they have given by
> saying if they don't release their code we won't support anything to do
> with it. Carrots work better than sticks.

Carrots work on rabbits, they don't work on hungry weasels.

Where there are fundamental interfaces for genuinely seperate works then
EXPORT_SYMBOL is appropriate. When its part of a shared library of GPL code
for making GPL driver writing easier then EXPORT_SYMBOL_GPL is appropriate.

In most respects it is up to the authors. You should also bear in mind that
we have authors who are not prepared to see GPL code potentially abused and
who would stop contributing to the linux kernel if EXPORT_SYMBOL_GPL was
not available
