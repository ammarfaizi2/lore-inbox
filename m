Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSKNCZk>; Wed, 13 Nov 2002 21:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSKNCZk>; Wed, 13 Nov 2002 21:25:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261318AbSKNCZj>; Wed, 13 Nov 2002 21:25:39 -0500
Date: Wed, 13 Nov 2002 18:32:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module mess in -CURRENT
In-Reply-To: <1037240840.14393.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211131828480.6810-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Nov 2002, Alan Cox wrote:
> 
> That makes driver debugging almost impossible. It also makes building a
> test kernel set for a lot of boxes impractical. The completely broken
> unload stuff is going to be a real pig, PCMCIA only works modular and
> doesn't work now the unloads are all broken.

Yeah, I forgot about the old 16-bit pcmcia crud. Ugh. At least 32-bit 
cardbus works fine.

> The biggest need though is documentation so people can actually fix all
> the drivers for this stuff.

I think Al convinced Rusty that most drivers don't need to worry and that
Rusty was a bit over-eager (ie sound, much of char, all of block and fs
should all be handled by upper layers without the races)

I think Rusty has most of the pieces, but he's apparently flying around 
the world right now ;)

		Linus

