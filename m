Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144004AbRAHO61>; Mon, 8 Jan 2001 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144152AbRAHO6R>; Mon, 8 Jan 2001 09:58:17 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:29009 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S144004AbRAHO57>; Mon, 8 Jan 2001 09:57:59 -0500
Date: Mon, 8 Jan 2001 17:04:58 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Andries.Brouwer@cwi.nl
cc: matthias.andree@stud.uni-dortmund.de,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <UTC200101061645.RAA145723.aeb@texel.cwi.nl>
Message-ID: <Pine.LNX.4.21.0101081701490.10084-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001 Andries.Brouwer@cwi.nl wrote:

> > It's not that simple.. The maxtor comes clipped,. but Linux can't kill the
> > clip. So it sticks with 32 MB
> 
> > ibmsetmax.c does a software clip, but that bugs a bit. Sometimes even
> > Linux doesn't see 61 GB, but only 32, sometimes the full capacity.
> 
> Please don't talk vague useless garbage.
> There is no entity called "Linux". If you mean "the 2.4.0 kernel
> boot messages report 61 GB, fdisk 2.9s sees 32 GB, fdisk 2.10r sees 61 GB"
> then say so. If you mean something else, say what you mean.
> Precisely, with versions and everything.

2.2.18 sometimes sees 61 GB, sometimes 32 GB. I don't call that hard to
understand. And I don't use 2.4 on that machine, see previous posting. I
also mentined that I use 2.2.18 with Andre's IDE patches. 

> Since you have a Maxtor, my old setmax should suffice for you, it can kill
> the clip, and there is no reason to use ibmsetmax.c, that is a version for
> IBM disks. There should not be any need to use other machines.
> 
> If something changed for recent Maxtor disks, we would like to know,
> but only reliable, detailed reports are of any use.

It was probably t he BIOS of this newer machine that somehow killed the
software clip. I can't explain otherwise.

The setmax program initially gave errors, so that's why I switched to
ibmsetmax.

If the vague behaviour starts appearing again I'll debug the thing. For
now I blaim the award bios :)
 
> Andries


	Igmar 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
