Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319003AbSIDBpW>; Tue, 3 Sep 2002 21:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319004AbSIDBpV>; Tue, 3 Sep 2002 21:45:21 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:61849 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319003AbSIDBpU>;
	Tue, 3 Sep 2002 21:45:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Date: Wed, 4 Sep 2002 03:52:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020904013530.8E1ED2C0D2@lists.samba.org>
In-Reply-To: <20020904013530.8E1ED2C0D2@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mPLD-0005oQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 02:41, Rusty Russell wrote:
> In message <Pine.LNX.4.33.0209031610200.10759-100000@penguin.transmeta.com> you
>  write:
> > 
> > On Tue, 3 Sep 2002, Jamie Lokier wrote:
> > > 
> > >      1. struct list
> > >      2. struct list_node
> > > 
> > > With these two types, `list_add' et al. can actually _check_ that you
> > > got the arguments the right way around.
> > 
> > Well, the thing is, one of the _advantages_ of "struct list_head" is 
> > exactly the fact that the implementation is 100% agnostic about whether a 
> > list entry is the head, or just part of the list.
> 
> Excellent.  Well I'm glad that's sorted.
> 
> Now please apply my patch (which got sidelined by nomenclature fetishers),

Yep, half a frog in the blender is better than no frog.

-- 
Daniel
