Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSFFRpN>; Thu, 6 Jun 2002 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFFRpM>; Thu, 6 Jun 2002 13:45:12 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:63976 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317024AbSFFRpL>; Thu, 6 Jun 2002 13:45:11 -0400
Date: Thu, 6 Jun 2002 10:45:12 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2
In-Reply-To: <Pine.LNX.4.44.0206061110410.16548-100000@jester.mews>
Message-ID: <Pine.LNX.4.44.0206061041440.28577-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Matt Bernstein wrote:

> Since when was it OK to do a parallel make dep?

wow such a useful response.  can you point me where this is documented?

i've never seen "make -j3" cause *source files* to be deleted.  there's a
bug here somewhere.

-dean

>
> On Jun 5 dean gaudet wrote:
>
> >so i haven't had a chance to dig into this further, but i think there may
> >be some .PRECIOUS foo missing.  i had hit ^C a few times to cancel out a
> >"make -j3 dep", and a "make -j3 bzImage" while i tweaked other things...
> >and somehow in the process include/linux/sunrpc/svcsock.h disappeared.
>
>

