Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278297AbRJSETh>; Fri, 19 Oct 2001 00:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278298AbRJSET2>; Fri, 19 Oct 2001 00:19:28 -0400
Received: from www.wen-online.de ([212.223.88.39]:50699 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S278297AbRJSETP>;
	Fri, 19 Oct 2001 00:19:15 -0400
Date: Fri, 19 Oct 2001 06:19:27 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch and Performance of larger pipes
In-Reply-To: <E15uME1-0000Ht-00@bodnar42>
Message-ID: <Pine.LNX.4.33.0110190609400.639-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Ryan Cumming wrote:

> On October 18, 2001 11:07, Manfred Spraul wrote:
> > Could you test the attached singlecopy patches?
> >
> > with bw_pipe,
> > * on UP, up to +100%.
>
> Awesome! Although any improvement improvement in efficiency is a good thing,
> I am curious as to what uses pipes besides gcc -pipe. UNIX domain sockets
> (for local X11, for instance) aren't implemented as pipes, are they? What
> sort of real world performance gains could I expect from this patch?

If Manfred's patch helps gcc -pipe, then hopefully he'll submit it.
(or maybe we should just kill the -pipe switch from the kernel tree;)
In testing with a hefty parallel make, removing that switch produced
a nice speedup.

	-Mike

