Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262960AbSJFA0t>; Sat, 5 Oct 2002 20:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbSJFA0t>; Sat, 5 Oct 2002 20:26:49 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:19725 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262960AbSJFA0s>; Sat, 5 Oct 2002 20:26:48 -0400
Date: Sat, 5 Oct 2002 20:32:17 -0400
From: Ben Collins <bcollins@debian.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021006003217.GD585@phunnypharm.org>
References: <20021005175437.GK585@phunnypharm.org> <Pine.LNX.4.44L.0210052126281.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210052126281.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 09:27:25PM -0300, Rik van Riel wrote:
> On Sat, 5 Oct 2002, Ben Collins wrote:
> 
> > I've also been wanting to use bitkeeper to create a Subversion mirror of
> > the kernel repository,
> 
> You don't need to use bitkeeper for that, you can download all the
> bitkeeper changesets as patches from my ftp site:
> 
> ftp://nl.linux.org/pub/linux/bk2patch/

Oh, but that may be useless, unless you regenerate your patches whenever
the tree is reparented. I ran into this while trying to do the same
thing. Basing it on the ChangeSet ID is a waste, and it needs to be
based on the ChangeSet key instead (the ChangeSet ID for a given key can
change when a merge is done).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
