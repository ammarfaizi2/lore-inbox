Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSEQFRl>; Fri, 17 May 2002 01:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEQFRk>; Fri, 17 May 2002 01:17:40 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:46604 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315424AbSEQFRj>; Fri, 17 May 2002 01:17:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Thu, 16 May 2002 21:50:16 MST."
             <3CE48C08.B0E59851@zip.com.au> 
Date: Fri, 17 May 2002 15:20:38 +1000
Message-Id: <E178aAR-00020W-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CE48C08.B0E59851@zip.com.au> you write:
> Some explanation of how this works, and of why I should not fill
> your ear with toothpaste would be appreciated here.

When an include file is found using "-I dir", __FILE__ in that include
file is "dir/filename":

gcc -D__KERNEL__ -I/usr/src/working-2.5.15-bug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=delay  -c -o delay.o delay.c

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
