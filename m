Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288061AbSATXk1>; Sun, 20 Jan 2002 18:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSATXkR>; Sun, 20 Jan 2002 18:40:17 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:4868
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288061AbSATXkF>; Sun, 20 Jan 2002 18:40:05 -0500
Date: Sun, 20 Jan 2002 18:40:56 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202110290.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.40.0201201839530.490-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My worry is this. If we have different filesystems having their own page
buffer/caching daemons we'll definately introduce race conditions.

Say have 2 hard drives with ReiserFS and EXT3 and im copying data between
the two and each of them has their own daemons its going to get pretty
messy no?


On Sun, 20 Jan 2002, Rik van Riel wrote:

> On Sun, 20 Jan 2002, Shawn Starr wrote:
>
> > But why should each filesystem have to have a different method of
> > buffering/caching? that just doesn't fit the layered model of the
> > kernel IMHO.
>
> I think Hans will give up the idea once he realises the
> performance implications. ;)
>
> Rik
> --
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
>
>

