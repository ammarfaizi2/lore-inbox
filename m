Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbRDVC5M>; Sat, 21 Apr 2001 22:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135183AbRDVC5C>; Sat, 21 Apr 2001 22:57:02 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:52740 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S135181AbRDVC44>;
	Sat, 21 Apr 2001 22:56:56 -0400
Message-Id: <200104220228.f3M2St1s023522@sleipnir.valparaiso.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Sat, 21 Apr 2001 11:49:42 -0400." <20010421114942.A26415@thyrsus.com> 
Date: Sat, 21 Apr 2001 22:28:55 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> This is a proposal for an attribution metadata system in the Linux kernel
> sources.  The goal of the system is to make it easy for people reading
> any given piece of code to identify the responsible maintainer.  The
> motivation for this proposal is that the present system, a single
> top-level MAINTAINERS file, doesn't seem to be scaling well.

It has been my observation that human organizations over time grow
mechanisms for doing the routine (i.e., frequent) tasks quite efficiently,
while sporadic tasks are usually handled in ad hoc, case by case ways,
which can be very inefficient (and usually frustrating to the would-be
user).

In our case, the whole kernel development system is quite adept at soaking
up point patches (the bread-and-butter in LKM), while larger scope changes
(like the one you are proposing, and also some cleanup patch I proposed a
long while back, and the other scattered changes I've seen fly by) are very
infrequent and so not handled at all well.

Question is, is it really worth it to create specialized tools for this
very rare case? I suspect they would cost an enormous effort to create, and
will rot away before use. The observation by Alan that an applied (and even
a only proposed) patch will make somebody squeal if it steps on their toes
is perhaps the best tool for finding interested parties we can hope for in
a widely distributed, informal, and moreover ever changing development
organization. The MAINTAINERS file itself (maintainace of which is _much_
less work than what you propose) is (by your own account IIRC) incomplete
and out of date.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
