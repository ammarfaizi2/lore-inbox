Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbRGRNnP>; Wed, 18 Jul 2001 09:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbRGRNnF>; Wed, 18 Jul 2001 09:43:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:51474 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267883AbRGRNmr>; Wed, 18 Jul 2001 09:42:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Larry McVoy <lm@bitmover.com>,
        "Brian J. Watson" <Brian.J.Watson@compaq.com>
Subject: Re: Common hash table implementation
Date: Wed, 18 Jul 2001 15:46:42 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        schoebel@eicheinformatik.uni-stuttgart.de
In-Reply-To: <3B54DEF5.B85F57E4@compaq.com> <20010717183410.S29668@work.bitmover.com>
In-Reply-To: <20010717183410.S29668@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01071815464209.12129@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 July 2001 03:34, Larry McVoy wrote:
> We've got a fairly nice hash table interface in BitKeeper that we'd
> be happy to provide under the GPL.  I've always thought it would be
> cool to have it in the kernel, we use it everywhere.
>
> http://bitmover.com:8888//home/bk/bugfixes/src/src/mdbm

Oh goodie, lots of new hash functions to test :-)  I'll pass the
interesting ones on to the guys with the serious hash-testing equipment.

I think the original poster was thinking more along the lines of a
generic insertion, deletion and lookup interface, which we are now
doing in an almost-generic way in a few places.  Once place that is
distinctly un-generic is the buffer hash, for no good reason that I
can see.  This would be a good starting point for a demonstration.

--
Daniel
