Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSFCIDh>; Mon, 3 Jun 2002 04:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSFCIDg>; Mon, 3 Jun 2002 04:03:36 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:19705 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317305AbSFCIDf>; Mon, 3 Jun 2002 04:03:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] more copy_{to,from}_user fixes 
In-Reply-To: Your message of "Sun, 02 Jun 2002 04:01:10 -0300."
             <20020602070110.GJ19932@conectiva.com.br> 
Date: Mon, 03 Jun 2002 18:07:09 +1000
Message-Id: <E17Emrt-0000dp-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020602070110.GJ19932@conectiva.com.br> you write:
> Linus, some more, please consider pulling from:
> 
> http://kernel-acme.bkbits.net:8080/copy_to_from_user-2.5
> 
> I stopped this (re)audit when 544 were still to be reviewed. Bedtime 8)

Heh... Was this on 2.5.20?  If so, you're fast 8)

I didn't bother to check for anything other than "I use the return
value in a non-binary way": that's enough to keep me busy and
frustrated.

Not checking at all can keep code much simpler sometimes, too.
(And more codepaths, more bugs.)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
