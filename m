Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSLPUrp>; Mon, 16 Dec 2002 15:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLPUro>; Mon, 16 Dec 2002 15:47:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261333AbSLPUro>; Mon, 16 Dec 2002 15:47:44 -0500
Date: Mon, 16 Dec 2002 12:54:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Ben Collins <bcollins@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
In-Reply-To: <20021216123932.B6887@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0212161251440.1095-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Dec 2002, Larry McVoy wrote:
>
> > Alternatively, never EVER make a patch against the "current kernel
> > version". Only make a patch against the _last_ kernel that you merged
> > with, and if I cannot apply it I will tell you so. Making a patch just
> > between your tree and mine will _always_ end up losing fixes.
> 
> I think this is a good approach.  If people sent Linus patches with some
> indication of the baseline of the patch, such as BASELINE=v2.5.49 in the
> header of the patch,

The problem here is that I often cannot do a sane merge. 

I have no problem at all merging stuff that is a week old or so (major 
clashes happen sometimes, and I ask for help, but it's rare). However, if 
somebody really uses a major external CVS tree and does big patches, 
eventually the likelihood of a problem grows big enough that the patch 
sender might as well merge _first_ anyway, since otherwise I'll just ask 
for his help.

HOWEVER, even if I end up having to ask for help, this is probably 
preferable to the "just install my tree" approach, since at least we don't 
lose bugfixes and other updates silently.

		Linus

