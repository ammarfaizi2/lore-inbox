Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbQKNNW0>; Tue, 14 Nov 2000 08:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbQKNNWR>; Tue, 14 Nov 2000 08:22:17 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:29702 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131076AbQKNNWC>; Tue, 14 Nov 2000 08:22:02 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Modprobe local root exploit
Date: 14 Nov 2000 12:28:24 -0000
Organization: Alfie's Internet Node
Message-ID: <8urb58$k07$1@alfie.demon.co.uk>
In-Reply-To: <14864.6812.849398.988598@ns.caldera.de> <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk> <14864.12007.216381.254700@ns.caldera.de>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duwe@caldera.de (Torsten Duwe) writes:
> Chris Evans <chris@scary.beasts.org> writes:
> > What's wrong with isalnum() ?
> 
> Hm, must admit that I wasn't 100% sure if that's in the kernel lib or an evil
> gcc expands it inline to some static array lookup. Now I see that it's
> already in the kernel. Do some of you also sometimes wonder why the kernel is
> so big ;-) ?

Someone could make it a bit smaller by patching fs/jffs/interp.c and
arch/ppc/xmon/xmon.c to use the kernel lib, rather than their own
versions.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
