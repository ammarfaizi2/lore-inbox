Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSBJA74>; Sat, 9 Feb 2002 19:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSBJA7g>; Sat, 9 Feb 2002 19:59:36 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:56074 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S289061AbSBJA7b>; Sat, 9 Feb 2002 19:59:31 -0500
Date: Sun, 10 Feb 2002 11:59:13 +1100
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4))
Message-ID: <20020210005913.GA1993@gondor.apana.org.au>
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au> <3C65C4C5.C287A3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C65C4C5.C287A3@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 07:54:29PM -0500, Jeff Garzik wrote:
> Herbert Xu wrote:
> > 
> > Setup your key with an empty passphrase should do the trick.
> 
> Ug.  no.  That is way way insecure.
> 
> Most modern distros have an ssh-agent running as a parent of all
> X-spawned processed (including processes spawned by xterms).  So, one
> only needs to run
> 	ssh-add ~/.ssh/id_dsa ~/.ssh/identity
> once, and input your password once.  After that, no passwords are
> needed.

This is fine for interactive use.  But for a daily cron job, it's
just as insecure as no passphrases at all.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
