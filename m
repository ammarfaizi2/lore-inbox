Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265334AbRGBQ3u>; Mon, 2 Jul 2001 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265331AbRGBQ3k>; Mon, 2 Jul 2001 12:29:40 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:2800
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265143AbRGBQ3a>; Mon, 2 Jul 2001 12:29:30 -0400
Date: Mon, 2 Jul 2001 12:28:39 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Russell King <rmk@arm.linux.org.uk>
cc: Riley Williams <rhw@memalpha.cx>, Keith Owens <kaos@ocs.com.au>,
        Adam J Richter <adam@yggdrasil.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <20010702160351.B28778@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0107021223120.11480-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Jul 2001, Russell King wrote:

> > First, why is it "far too late" as you put it? It won't be the first
> > time config vars have been renamed, and it's unlikely to be the last
> > either...

Can we just break everything apart in 2.5 please?  Will this still be an
issue with CML2 anyway?

> I'm not going to cause disruption across the board to lots of people just
> because someone wants to keep the length of the symbols down.
>
> If you really do want to do this change, then I suggest that you get in
> touch with Nicolas Pitre and discuss it with him.  When you come to a
> conclusion, its not as simple as patching the kernel.  You need to
> update the database at www.arm.linux.org.uk/developer/machines/ to
> reflect the new symbols _at the same time_ that you change them in
> everyones tree, since anyone can pull down a new copy of the symbols
> from the database at any time.

For instance we might just keep the SA1100 out of the picture until we're
ready to make such change as "atomic" as possible for all people involved.


Nicolas

