Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbTAJRZl>; Fri, 10 Jan 2003 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTAJRZl>; Fri, 10 Jan 2003 12:25:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265705AbTAJRZk>; Fri, 10 Jan 2003 12:25:40 -0500
Date: Fri, 10 Jan 2003 09:29:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030110170625.GE23375@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.44.0301100921460.12833-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Dave Jones wrote:
> 
> What's happening with the OSS drivers ?
> I'm still carrying a few hundred KB of changes from 2.4 for those.
> I'm not going to spent a day splitting them up, commenting them and pushing
> to Linus if we're going to be dropping various drivers.

I consider them to be old drivers, the same way "hd.c" was. Not
necessarily useful for most people, but neither was hd.c. And it was
around for a _long_ time (heh. I needed to check. The config option is 
still there ;)

So I don't see a huge reason to remove them from the sources, but we might
well make them harder to select by mistake, for example. Right now the
config help files aren't exactly helpful, and the OSS choice is before the
ALSA one, which looks wrong. 

They should probably be marked deprecated, and if they don't get a lot of 
maintenance, that's fine.

		Linus

