Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUBEA1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBEA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:26:00 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:30366 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265162AbUBEAXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:23:30 -0500
Date: Wed, 4 Feb 2004 17:23:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205002328.GA5219@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org> <20040204232447.GC256@elf.ucw.cz> <20040204235508.GB1086@smtp.west.cox.net> <20040204161626.1a2f8885.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204161626.1a2f8885.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 04:16:26PM -0800, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > Andrew, what features of George's version don't you like?
> 
> This is bad:
> 
> akpm:/usr/src/25> grep '^+#ifdef' patches/kgdb-ga.patch | wc -l 
>      83
> 
> and the fact that it touches 36 different files.
> 
> Any time I've had to do any maintenance work against that stub I get lost
> in a twisty maze and just whine at George about it.  It's just all over the
> place.  Yes, this is partly the nature of the beast, but I don't see that a
> ton of effort has been put into reducing the straggliness.
> 
> > Right now
> > I'm working on moving the kgdb-eth driver that uses netpoll over
> > into Amit's version, and thinking of a cleaner away to allow for both
> > early debugging and multiple drivers (eth or serial A or serial B).
> 
> Sounds good.
> 
> Look, there's a lot of interest in this and I of course am fully
> supportive.  If someone could send me Amit's patchset when they think I
> should test it, I could then talk about it more usefully.

Alright.  I hope to soon have netpoll'ed kgdb-over-ethernet happy.  From
there, I'll send you a patch that's Amit's work + cleanups / fixes, and
better PPC support.  Then we can see which features are in George's
version become a must-have.

-- 
Tom Rini
http://gate.crashing.org/~trini/
