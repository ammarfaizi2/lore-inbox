Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRLWXGZ>; Sun, 23 Dec 2001 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLWXGP>; Sun, 23 Dec 2001 18:06:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:19426 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284176AbRLWXGD>;
	Sun, 23 Dec 2001 18:06:03 -0500
Date: Mon, 24 Dec 2001 00:05:57 +0100
Message-Id: <200112232305.fBNN5vM19844@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E16I8zQ-0000d9-00@the-village.bc.nu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16I8zQ-0000d9-00@the-village.bc.nu> you wrote:
>> Basically what Grub does is loads the kernel modules from disk
>> into memory, and 'tells' the kernel the memory location to load
>> them from, very similar to how an initrd file is loaded. The problem
>> is Linux, is not MBS compilant and doesn't know to look for and load
>> the modules. 

> And vendors who've shipped GRUB still have to ship Lilo because Grub plain
> doesn't work on some machines. Lilo has the virtue that its extremely simple
> in what it does and how it does it. It works in a suprisingly large number
> of cases and can handle interesting setups that GRUB really struggles with.

Apart that it moves the initrd somewhere unsafe on high memory machines
and some other odds ends we have fixed, I know of exactly 1 problem with a
hw raid controller, which we did not come around to debug yet.

All other machines, obscure as they may are, boot just fine and without  
problems with GRUB.

Ciao, Marcus
