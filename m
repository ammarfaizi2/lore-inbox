Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273235AbRIWVtl>; Sun, 23 Sep 2001 17:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273326AbRIWVt2>; Sun, 23 Sep 2001 17:49:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273235AbRIWVtY>; Sun, 23 Sep 2001 17:49:24 -0400
Subject: Re: Linux-2.4.10
To: landley@trommello.org
Date: Sun, 23 Sep 2001 22:54:24 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <01092312415107.01503@localhost.localdomain> from "Rob Landley" at Sep 23, 2001 12:41:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lHCi-0000XO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody care to venture an opinion why a menu for "Fusion MPT Device Support" 
> shows up between SCSI and Firewire in the main menu of make menuconfig, but I 
> can't get into it?  I press enter and the main menu just redraws.  My .config 
> is attached.  (Never hand-hacked, but carried forward from...  2.4.7, I 
> think.)

Because menuconfig doesnt do the right thing when the menu only contains
items you cant select for other reasons

> the new serverworks he/le agpgart support, or PNPBios support under plug and 
> pray...  I'll go bug Eric.

PnPBIOS is only in -ac. There is help for it there. In fact there is a lot
of help text only in -ac but merging them all is non trivial and I figured
code first was better
