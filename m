Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSETTzM>; Mon, 20 May 2002 15:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316316AbSETTzL>; Mon, 20 May 2002 15:55:11 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:47013 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316309AbSETTzK>; Mon, 20 May 2002 15:55:10 -0400
Date: Mon, 20 May 2002 14:55:10 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mike Ramsey <mramsey@ansivirus.mine.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.18 kernel downloaded from kernel.org
In-Reply-To: <1021923468.22591.7.camel@ansivirus.mine.nu>
Message-ID: <Pine.LNX.4.44.0205201450010.31691-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2002, Mike Ramsey wrote:

> make[1]: Entering directory `/usr/src/linux-2.4.18-6mdk/drivers'
> make -C atm modules
> make[2]: Entering directory `/usr/src/linux-2.4.18-6mdk/drivers/atm'
> make[2]: *** No rule to make target
> `/home/quintela/rpm/2418/BUILD/linux/include/linux/module.h', needed by
> `eni.o'.  Stop.
> make[2]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers/atm'
> make[1]: *** [_modsubdir_atm] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.18-6mdk/drivers'
> make: *** [_mod_drivers] Error 2

Hmmh, 2.4.18 from kernel.org would not be in a directory called 
linux-2.4.18-6mdk, would it?

I don't know what you did, but you seemed to have messed something up 
between your tree and the tree your distribution provided.

Anyway, you can probably solve your problem by running "make dep". If that
does not help, try

	http://www.tux.org/lkml/#s8-8

--Kai

