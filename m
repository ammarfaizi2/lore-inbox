Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268811AbRG3Og1>; Mon, 30 Jul 2001 10:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268800AbRG3OgP>; Mon, 30 Jul 2001 10:36:15 -0400
Received: from Expansa.sns.it ([192.167.206.189]:39944 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268618AbRG3Of7>;
	Mon, 30 Jul 2001 10:35:59 -0400
Date: Mon, 30 Jul 2001 16:35:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
cc: Steffen Persvold <sp@scali.no>, Gav <gavbaker@ntlworld.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <Pine.LNX.4.33.0107301213440.15803-100000@druid.if.uj.edu.pl>
Message-ID: <Pine.LNX.4.33.0107301619570.11467-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have this bios setting enabled, and no problems at all on two of my
athlons with VIA KT133A, kernel 2.4.7.

>From this full discussion comes out a big confusion.

For what I saw, many  VIA KT133A do work well, many other
give problems to their sysadmins. but the chipset is almost the same,
and the processors are quite the same (they are all athlon, I read no
bug reports about duron).

this is enought for me to get confused.

My production systems do use scsi disks, and i can understand
they donot have troubles (adaptec 2940, 2980 29160....).
But also the ones with IDE disks are working quite well (some using
ata33, others ata100).
I NEVER used DDRAM, just normal SDRAM 133 Mhz.

So I was thinking to FSB. All my systems with ide disks have 200MhzFSB,
(while my latest production systems do have 266 MhzFSB). Maybe a 266
MhzFSB is just too mutch stress
for some via chipset. But i see no clear logic when problems do appear,
or any big difference with systems that are rock solid.

lets' try to make a point to see a logic for those instabilities...

which kind of hardware bug is this, if the same chipset can work or not
depending  if you are lucky? or a full stock of chipset is buggy and
with a certain HW configuration you will see the bug or
what?

Luigi

On Mon, 30 Jul 2001, Maciej Zenczykowski wrote:

> > Hmm, I think "DRAM Prefetch" is the one you _don't_ want to turn on, because (and correct
> > me if i'm wrong) it's causing all the problems with the IDE controller (data trashing).
>
> I think it was IDE Prefetch that should be off (I had this problem on a
> AMD 486DX4-133 with Award Bios, turning it on trashed the boot record in
> minutes (and many other sectors on the disk too).
>
> Anyone here care to give a link to that program to enable DRAM Prefetch?
> My sister has a Duron 750w with VIA motherboard and music and sound pop on
> any graphics changes, maybe this is it?
>
> Regards,
>
> Maciej Zenczykowski
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

