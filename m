Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSKCAPr>; Sat, 2 Nov 2002 19:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSKCAPr>; Sat, 2 Nov 2002 19:15:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51218 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261520AbSKCAPq>; Sat, 2 Nov 2002 19:15:46 -0500
Date: Sat, 2 Nov 2002 16:22:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44L.0211022214580.3411-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, Rik van Riel wrote:
> 
> Sure it's more flexible, but I wonder how many userland
> programs will be broken if we change the permission model
> and how well users can protect their data this way.

This is not a "change". Existing behaviour clearly cannot change. We're 
talking about new interfaces to export capabilities in the filesystem.

And pathnames are a _hell_ of a lot better and straightforward interface
than inode numbers are. It's confusing when you change the permission on
one path to notice that another path magically changed too.

		Linus

