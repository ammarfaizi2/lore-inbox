Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSKCAMY>; Sat, 2 Nov 2002 19:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSKCAMY>; Sat, 2 Nov 2002 19:12:24 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:3745 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261521AbSKCAMX>; Sat, 2 Nov 2002 19:12:23 -0500
Date: Sat, 2 Nov 2002 22:18:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0211022214580.3411-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Linus Torvalds wrote:

> Clearly inode numbers are a bad way to handle it, but I don't think
> inode attributes are that great either. I would personally prefer
> directory entry attributes, so that the same file can show up with
> different behaviour in different places.

I'm sure we can come up with even more confusing behaviour
if we want, but it'll take some serious creativity.

Sure it's more flexible, but I wonder how many userland
programs will be broken if we change the permission model
and how well users can protect their data this way.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

