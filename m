Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSATXth>; Sun, 20 Jan 2002 18:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSATXtS>; Sun, 20 Jan 2002 18:49:18 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:26887 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288971AbSATXs6>;
	Sun, 20 Jan 2002 18:48:58 -0500
Date: Sun, 20 Jan 2002 21:48:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.40.0201201839530.490-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33L.0201202145070.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Shawn Starr wrote:

> My worry is this. If we have different filesystems having their own page
> buffer/caching daemons we'll definately introduce race conditions.
>
> Say have 2 hard drives with ReiserFS and EXT3 and im copying data between
> the two and each of them has their own daemons its going to get pretty
> messy no?

Each of the "cache daemons" will react differently to VM
pressure, meaning the system will most definately get out
of balance.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

