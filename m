Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315523AbSEQJjy>; Fri, 17 May 2002 05:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSEQJjx>; Fri, 17 May 2002 05:39:53 -0400
Received: from [202.135.142.196] ([202.135.142.196]:12553 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315523AbSEQJjw>; Fri, 17 May 2002 05:39:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Fri, 17 May 2002 08:56:56 +0100."
             <Pine.LNX.4.21.0205170839240.1369-100000@localhost.localdomain> 
Date: Fri, 17 May 2002 19:43:18 +1000
Message-Id: <E178eGc-0008MY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0205170839240.1369-100000@localhost.localdomain> you 
write:
> On Fri, 17 May 2002, Rusty Russell wrote:
> > 
> > Um, show me where sizeof(KBUILD_BASENAME) + sizeof(__FUNCTION__) >
> > sizeof(__FILENAME__).
> 
> If you're talking about kbuild2.5

No.  It's the include files, which makes up the majority of strings.
See reply to Andrew Morton.

Summary: faster cached compiles no bloat,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
