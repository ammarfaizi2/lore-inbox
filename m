Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317379AbSFKRzD>; Tue, 11 Jun 2002 13:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317384AbSFKRzC>; Tue, 11 Jun 2002 13:55:02 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37811 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317379AbSFKRzA>;
	Tue, 11 Jun 2002 13:55:00 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of Tue, 11 Jun 2002 01:33:54 PDT.
             <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15686.1023818044.1@us.ibm.com>
Date: Tue, 11 Jun 2002 10:54:04 -0700
Message-Id: <E17HpqG-000454-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>, > : Li
nus Torvalds writes:
> 
> 
> On Tue, 11 Jun 2002, Rusty Russell wrote:
> >
> > Worst sin is that you can't predeclare typedefs.  For many uses (not the
> > list macros of course):
> > 	struct xx;
> > is sufficient and avoids the #include hell,
> 
> True.

Untrue.  Or partially true (yes, you *can* use struct xx;).

But you can also use:

typedef foo_t;

to predefine, just like you can use struct xx;

Also avoids some aspects of #include <hell>.

gerrit
