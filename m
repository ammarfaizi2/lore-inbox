Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132827AbRDIT0a>; Mon, 9 Apr 2001 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRDIT0U>; Mon, 9 Apr 2001 15:26:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18290 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132827AbRDIT0P>; Mon, 9 Apr 2001 15:26:15 -0400
Date: Mon, 9 Apr 2001 21:27:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol in 2.4.4p1, ia32
Message-ID: <20010409212726.I8138@athlon.random>
In-Reply-To: <44f.3acf8044.2edba@trespassersw.daria.co.uk> <E14mgrp-0002gJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14mgrp-0002gJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 09, 2001 at 07:58:23PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 07:58:23PM +0100, Alan Cox wrote:
> > depmod: *** Unresolved symbols in 
> >         /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
> > depmod: 	strstr
> > 
> > depmod: *** Unresolved symbols in 
> >         /lib/modules/2.4.4-pre1/kernel/drivers/parport/parport.o
> > depmod: 	strstr
> 
> That'll be from my patches. Now I am back I'll check over the stuff I sent
> Linus and see what escaped/got dropped/didnt get sent. I suspect its a missing
> EXPORT entry

Yep.

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre1/strstr-1

Andrea
