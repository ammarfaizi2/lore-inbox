Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317683AbSGUOrI>; Sun, 21 Jul 2002 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317687AbSGUOrI>; Sun, 21 Jul 2002 10:47:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:37133 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317683AbSGUOrH>; Sun, 21 Jul 2002 10:47:07 -0400
Date: Sun, 21 Jul 2002 11:50:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Rodland <arodland@noln.com>
cc: Martin Josefsson <gandalf@wlug.westbo.se>, <mru@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: memory leak?
In-Reply-To: <20020722102658.731a2200.arodland@noln.com>
Message-ID: <Pine.LNX.4.44L.0207211149460.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Andrew Rodland wrote:
> On 21 Jul 2002 16:20:39 +0200
> Martin Josefsson <gandalf@wlug.westbo.se> wrote:
>
> > free don't know about slabcaches. take a look in /proc/slabinfo and
> > see what's using that memory. it's not a leak, the memory will be
> > free'd when the machine is under enough memory pressure.
>
> Yeah... look at that. looks like I've got quite a bit of memory
> invested in inode_cache and dentry_cache. There's no way to have them
> reported as "cache" memory anymore?

Submit patches for procps to make free examine /proc/slabinfo ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

