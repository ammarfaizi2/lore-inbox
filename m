Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSAMWNF>; Sun, 13 Jan 2002 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288184AbSAMWM4>; Sun, 13 Jan 2002 17:12:56 -0500
Received: from host5.mileniumnet.com.br ([200.199.222.5]:24840 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S288174AbSAMWMn>; Sun, 13 Jan 2002 17:12:43 -0500
Date: Sun, 13 Jan 2002 17:23:11 -0200 (BRST)
From: Thiago Rondon <maluco@mileniumnet.com.br>
X-X-Sender: <maluco@freak.linuxms.com.br>
To: Alan Cox <alan@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <200201132144.g0DLikH27385@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33L.0201131721110.4750-100000@freak.linuxms.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[maluco@freak maluco]$ finger @kernel.org
[kernel.org]
The latest stable version of the Linux kernel is:          2.4.17
The latest prepatch for the stable Linux kernel tree is:   2.4.18-pre3
The latest beta version of the Linux kernel is:            2.5.1
The latest prepatch for the beta Linux kernel tree is:     2.5.2-pre11
The latest -ac patch to the stable Linux kernels is:       2.4.13-ac8

That message is "maintainer" by someone? The -ac tree isnt update.

On Sun, 13 Jan 2002, Alan Cox wrote:

> People keep bugging me about the -ac tree stuff so this is whats in my
> current internal diff with the ll patch and the ide changes excluded.
>
> Much of this is stuff just waiting to go to Marcelo but it has the 32bit
> uid quota that some folks consider pretty critical and the rmap-11b VM
> which I consider pretty essential
>
> (Marcelo I'll be sending you stuff I've done from this anyway, if there
>  is other stuff you want extracting just ask)
>
> Linux 2.4.18pre3-ac1
>
> o	32bit uid quota
> o	rmap-11b VM					(Rik van Riel,
> 							 William Irwin etc)
> o	Make scsi printer visible			(Stefan Wieseckel)
> o	Report Hercules Fortissimo card			(Minya Sorakinu)
> o	Fix O_NDELAY close mishandling on the following	(me)
> 	sound cards: cmpci, cs46xx, es1370, es1371,
> 	esssolo1, sonicvibes
> o	tdfx pixclock handling fix			(Jurriaan)
> o	Fix mishandling of file system size limiting	(Andrea Arcangeli)
> o	generic_serial cleanups				(Rasmus Andersen)
> o	serial.c locking fixes for SMP - move from cli	(Kees)
> 	too
> o	Truncate fixes from old -ac tree		(Andrew Morton)
> o	Hopefully fix the i2o oops			(me)
> 	| Not the right fix but it'll do till I rewrite this
> o	Fix non blocking tty blocking bug		(Peter Benie)
> o	IRQ routing workaround for problem HP laptops	(Cory Bell)
> o	Fix the rcpci driver				(Pete Popov)
> o	Fix documentation of aedsp location		(Adrian Bunk)
> o	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
> o	Correct icmp documentation			(Pierre Lombard)
> o	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
> o	ldm header fix					(Anton Altaparmakov)
> o	Fix unchecked kmalloc in i2o_proc	(Ragnar Hojland Espinosa)
> o	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
> o	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
> o	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
> o	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
> o	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
> o	Fix compilation of orinoco driver		(Ben Herrenschmidt)
> o	ISAPnP init fix					(Chris Rankin)
> o	Export release_console_sem			(Andrew Morton)
> o	Output nat crash fix				(Rusty Russell)
> o	Fix PLIP					(Tim Waugh)
> o	Natsemi driver hang fix				(Manfred Spraul)
> o	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

