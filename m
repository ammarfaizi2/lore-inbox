Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSKCDQz>; Sat, 2 Nov 2002 22:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSKCDQz>; Sat, 2 Nov 2002 22:16:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37130 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261574AbSKCDQy>; Sat, 2 Nov 2002 22:16:54 -0500
Date: Sat, 2 Nov 2002 19:23:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211021922280.2354-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Alexander Viro wrote:
>
> 	<shrug> that can be done without doing anything to filesystem.
> Namely, turn current "nosuid" of vfsmount into a mask of capabilities.
> Then use bindings instead of links.

I like that idea. It's very explicit, and clearly name-based, and we do
have 99% of the support for it already.

		Linus

