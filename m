Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270678AbRHJXDu>; Fri, 10 Aug 2001 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270679AbRHJXDk>; Fri, 10 Aug 2001 19:03:40 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:36341
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S270678AbRHJXD2>; Fri, 10 Aug 2001 19:03:28 -0400
Date: Fri, 10 Aug 2001 19:03:33 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <3B745990.7040808@zytor.com>
Message-ID: <Pine.LNX.4.33.0108101902380.25254-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2001, H. Peter Anvin wrote:

> Linus Torvalds wrote:
> >
> > These days, the vma's just have too much information, and the
> > page tables
> > can't be counted on to have enough bits.
> >
>
> Note that it isn't very hard to deal with *that* problem, *if you want
> to*... you just need to maintain a shadow data structure in the same
> format as the page tables and stuff your software bits in there.

This technique is already used on ARM.


Nicolas

