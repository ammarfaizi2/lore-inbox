Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286889AbRLWNjZ>; Sun, 23 Dec 2001 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286885AbRLWNjP>; Sun, 23 Dec 2001 08:39:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286884AbRLWNjC>; Sun, 23 Dec 2001 08:39:02 -0500
Subject: Re: Booting a modular kernel through a multiple streams file
To: dcinege@psychosis.com
Date: Sun, 23 Dec 2001 13:48:31 +0000 (GMT)
Cc: otto.wyss@bluewin.ch,
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        rusty@rustcorp.com.au (Rusty Russell)
In-Reply-To: <E16HwC0-0001k4-00@schizo.psychosis.com> from "Dave Cinege" at Dec 22, 2001 07:08:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16I8zQ-0000d9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically what Grub does is loads the kernel modules from disk
> into memory, and 'tells' the kernel the memory location to load
> them from, very similar to how an initrd file is loaded. The problem
> is Linux, is not MBS compilant and doesn't know to look for and load
> the modules. 

And vendors who've shipped GRUB still have to ship Lilo because Grub plain
doesn't work on some machines. Lilo has the virtue that its extremely simple
in what it does and how it does it. It works in a suprisingly large number
of cases and can handle interesting setups that GRUB really struggles with.
