Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263221AbSIRDL3>; Tue, 17 Sep 2002 23:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263576AbSIRDL3>; Tue, 17 Sep 2002 23:11:29 -0400
Received: from dp.samba.org ([66.70.73.150]:21193 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263221AbSIRDL3>;
	Tue, 17 Sep 2002 23:11:29 -0400
Date: Wed, 18 Sep 2002 13:11:41 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bart Trojanowski <bart@jukie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 fix for fuzzy hash <linux/ghash.h>
Message-Id: <20020918131141.1938a4d8.rusty@rustcorp.com.au>
In-Reply-To: <20020911140232.R32387@jukie.net>
References: <20020911140232.R32387@jukie.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002 14:02:32 -0400
Bart Trojanowski <bart@jukie.net> wrote:

> The DEF_HASH_FUZZY macro allows the user to template their hash; it
> takes on a paramter for the hashing-function, namely HASHFN.  When used
> with a hashing-function named anything other than 'hashfn()', a module
> using the kernel's fuzzy hash implementation will not compile.
> 
> None of the in-kernel 2.4.x drivers use this primitive (yet) so it's no
> wonder no one has spotted it.  The patch is very trivial and makes me
> think that I am the very first user of the include/linux/ghash.h
> hash-table primitive.   ;)

That's why I was going to submit a patch to turf it out in 2.5.
2.5's include/hash.h provides a hashing function: did you really want ghash.h?

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
