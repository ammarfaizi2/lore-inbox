Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSFKH5b>; Tue, 11 Jun 2002 03:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFKH53>; Tue, 11 Jun 2002 03:57:29 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:28388 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316910AbSFKH47>; Tue, 11 Jun 2002 03:56:59 -0400
Date: Tue, 11 Jun 2002 18:00:51 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dent@cosy.sbg.ac.at, adilger@clusterfs.com, da-x@gmx.net,
        patch@luckynet.dynu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
Message-Id: <20020611180051.6007ae94.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0206101011440.30535-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002 10:21:36 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:
> Well, it's more than just "struct xx". It's really typedefs in general.

Worst sin is that you can't predeclare typedefs.  For many uses (not the
list macros of course):
	struct xx;
is sufficient and avoids the #include hell,

Cheers
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
