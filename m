Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSJOUjb>; Tue, 15 Oct 2002 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSJOUjb>; Tue, 15 Oct 2002 16:39:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26541 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264788AbSJOUix>;
	Tue, 15 Oct 2002 16:38:53 -0400
Date: Tue, 15 Oct 2002 16:44:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniele Lugli <genlogic@inrete.it>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
In-Reply-To: <3DAC7AAC.B81A406E@inrete.it>
Message-ID: <Pine.GSO.4.21.0210151633410.10323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Oct 2002, Daniele Lugli wrote:

> But let me at least summarize my poor-programmer-not-kernel-developer
> point of view: at present the kernel if a mined field for c++ and i
> understand it is not viable nor interesting for the majority to rewrite
> it in a more c++-friendly way. But why not at least keep in mind, while
> writing new stuff (not the case of current.h i see), that kernel headers
> could be included by c++?

current.h is, indeed, a special case.  #define i j would not be tolerated
simply because it's stupid.  Abuses of preprocessor are generally frowned
upon, but there are passionate wa^H^Hpersons who just can't help themselves
and use e.g. ## for no good reason.

But as for C++... frankly, for all I care it doesn't exist.  As long as
requirements of style happen to reduce problems of C++ programmers -
they are lucky.  But other than that... watch me not care.  In the linux
kernel context C++ is obscure language and it will stay that way.  Ergo,
no reasons to spend any mental efforts on being nice to it.  Deal.

