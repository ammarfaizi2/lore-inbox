Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCRWya>; Mon, 18 Mar 2002 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293218AbSCRWy0>; Mon, 18 Mar 2002 17:54:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48648 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293205AbSCRWyP>; Mon, 18 Mar 2002 17:54:15 -0500
Date: Mon, 18 Mar 2002 23:54:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Message-ID: <20020318225403.GE1740@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu> <Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu> <20020318192502.GD194@elf.ucw.cz> <shs1yeha5b4.fsf@charged.uio.no> <20020318223827.GD1740@atrey.karlin.mff.cuni.cz> <15510.28326.558485.955067@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>      > Okay, take userland nfs-server. (This thread was about userland
>      > filesystems).
> 
> Yech... Nobody should be seriously considering using unfsd: it does
> not even manage to follow the NFS protocol. That inability was one of
> the many reasons why Olaf Kirch abandoned further develpement of unfsd
> and started work on knfsd.
> 
>      > Then, make memory full of dirty pages. Imagine that nfs-server
>      > is swapped-out by some bad luck. What you have is extremely
>      > nasty deadlock, AFAICS. [To free memory you have to write out
>      > dirty data, but you can't do that because you don't have enough
>      > memory for nfs-server].
> 
> So that is another argument for using knfsd rather than unfsd. I will
> agree with you that NFS is not perfect, but please judge it on its
> actual merits and not on some trumped up charge...

Sorry, this thread was about userland filesystems, and NFS is just not
usefull there (for read/write case).

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
