Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSFCIHM>; Mon, 3 Jun 2002 04:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSFCIHL>; Mon, 3 Jun 2002 04:07:11 -0400
Received: from 1-173.ctame701-2.telepar.net.br ([200.181.138.173]:55030 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S317307AbSFCIHK>; Mon, 3 Jun 2002 04:07:10 -0400
Date: Sun, 2 Jun 2002 05:06:50 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] more copy_{to,from}_user fixes
Message-ID: <20020602080650.GA20603@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020602070110.GJ19932@conectiva.com.br> <E17Emrt-0000dp-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 03, 2002 at 06:07:09PM +1000, Rusty Russell escreveu:
> In message <20020602070110.GJ19932@conectiva.com.br> you write:
> > Linus, some more, please consider pulling from:
> > 
> > http://kernel-acme.bkbits.net:8080/copy_to_from_user-2.5
> > 
> > I stopped this (re)audit when 544 were still to be reviewed. Bedtime 8)
> 
> Heh... Was this on 2.5.20?  If so, you're fast 8)

yes 8)
 
> I didn't bother to check for anything other than "I use the return
> value in a non-binary way": that's enough to keep me busy and
> frustrated.
> 
> Not checking at all can keep code much simpler sometimes, too.
> (And more codepaths, more bugs.)

humm, but if it can fail...

- Arnaldo
