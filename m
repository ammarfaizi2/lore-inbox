Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266131AbRGGMCe>; Sat, 7 Jul 2001 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbRGGMCY>; Sat, 7 Jul 2001 08:02:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266131AbRGGMCJ>; Sat, 7 Jul 2001 08:02:09 -0400
Subject: Re: drivers/ide/sl82c105.c
To: paulus@samba.org
Date: Sat, 7 Jul 2001 13:02:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15174.29463.304974.820632@tango.paulus.ozlabs.org> from "Paul Mackerras" at Jul 07, 2001 12:25:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IqnD-0005jg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering who maintains drivers/ide/sl82c105.c, and who sent in
> the recent changes to it.  We now have, at around line 278, this code:
> 
> unsigned int pci_init_sl82c105(struct pci_dev *dev, const char *msg)
> {
>         return ide_special_settings(dev, msg);
> }
> 
> The call to ide_special_settings gives a link error because

The IDE stuff isnt fully merged right now. There are some quite tricky things
to sort out there.


