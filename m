Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSHAUry>; Thu, 1 Aug 2002 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSHAUry>; Thu, 1 Aug 2002 16:47:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315529AbSHAUrx>; Thu, 1 Aug 2002 16:47:53 -0400
Date: Thu, 1 Aug 2002 13:51:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208012241390.8911-100000@serv>
Message-ID: <Pine.LNX.4.33.0208011348430.12015-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, Roman Zippel wrote:
> >
> > In short, this is not something that can be discussed. It's a cold fact, a
> > law of UNIX if you will.
> 
> Any program setting up signal handlers should expext interrupted i/o,
> otherwise it's buggy.

Roman, THAT IS JUST NOT TRUE!

Go read the standards. Some IO is not interruptible. This is not something 
I'm making up, and this is not something that can be discussed about. The 
speed of light in vacuum is 'c', regardless of your own relative speed. 
And file reads are not interruptible.

			Linus

