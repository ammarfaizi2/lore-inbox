Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262171AbSJJTNX>; Thu, 10 Oct 2002 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJJTM1>; Thu, 10 Oct 2002 15:12:27 -0400
Received: from dsl-213-023-020-143.arcor-ip.net ([213.23.20.143]:15555 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262165AbSJJTLW>;
	Thu, 10 Oct 2002 15:11:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Bart Trojanowski <bart@jukie.net>
Subject: Re: [PATCH] [2.4.19] fix for fuzzy hash <linux/ghash.h> [Attempt 2]
Date: Thu, 10 Oct 2002 21:17:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20021006170124.D28201@jukie.net> <20021007052255.GG1201@conectiva.com.br>
In-Reply-To: <20021007052255.GG1201@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17zioI-0000Ds-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 07:22, Arnaldo Carvalho de Melo wrote:
> Em Sun, Oct 06, 2002 at 05:01:24PM -0400, Bart Trojanowski escreveu:
> > wonder no one has spotted it.  The patch is very trivial and makes me
> > think that I am the very first user of the include/linux/ghash.h
> > hash-table primitive.   ;)
> 
> Somebody told me that this was used in when dentry was introduced to the
> kernel, but then after rewrites it stopped being used, I was even thinking
> about submitting a patch removing it from the tree, but now there is one user,
> you :-)

Too bad, should have acted faster ;-)

This attempt is much like the single linked lists: it looks like something you
ought to be able to generalize, but somehow it never quite works.  Writing
the code out in full gives you a more efficient, more compact result every
time.

-- 
Daniel
