Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSEQEWm>; Fri, 17 May 2002 00:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSEQEWm>; Fri, 17 May 2002 00:22:42 -0400
Received: from [202.135.142.196] ([202.135.142.196]:47884 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315415AbSEQEWl>; Fri, 17 May 2002 00:22:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Thu, 16 May 2002 19:41:58 MST."
             <3CE46DF6.62EF67E0@zip.com.au> 
Date: Fri, 17 May 2002 14:25:34 +1000
Message-Id: <E178ZJ8-0001TJ-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CE46DF6.62EF67E0@zip.com.au> you write:
> I'd share Hugh's concern on this one.  Adding the name of the
> containing function to every BUG() expansion will increase
> the size of .rodata.

Andrew: you used to be such a bright young man. 8)

> Do you have before-and-after /usr/bin/size output?

I even put the kernel in /usr/src/, not my home directory, to help you
out here.

before: 
	   text    data     bss     dec     hex filename
	1192605  355848  353780 1902233  1d0699 vmlinux

after: 
	   text    data     bss     dec     hex filename
	1168396  355848  353780 1878024  1ca808 vmlinux

Understand?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
