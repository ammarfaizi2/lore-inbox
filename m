Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSESE4p>; Sun, 19 May 2002 00:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSESE4o>; Sun, 19 May 2002 00:56:44 -0400
Received: from panda.sul.com.br ([200.219.150.4]:11794 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314082AbSESE4o>;
	Sun, 19 May 2002 00:56:44 -0400
Date: Sat, 18 May 2002 19:55:35 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020518225535.GA4101@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heads up: I'm finishing a bk changeset for intermezzo, will be submitting
to Linus in some minutes.

- Arnaldo

Em Sun, May 19, 2002 at 02:18:53PM +1000, Rusty Russell escreveu:
> The following uses seem to be incorrect: copy_from_user and
> copy_to_user return the number of bytes NOT copied on failure, not
> -EFAULT.
> 
> You can CC: fixups to trivial at rustcorp.com.au.
> 
> (I didn't look for cases where the Torvalds/McVoy philosophy says we
> should be returning a partial result on EFAULT: that's more complex).
> 
> Thanks,
> Rusty.
> ================
> Some cases are endemic: whole subsystems or drivers where the author
> obviously thought copy_from_user follows the kernel conventions:
> 
> Whole Subsystems:
> fs/intermezzo/*.c

<SNIP>
