Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRCARuy>; Thu, 1 Mar 2001 12:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRCARup>; Thu, 1 Mar 2001 12:50:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:3324 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129608AbRCARuk>; Thu, 1 Mar 2001 12:50:40 -0500
Date: Thu, 1 Mar 2001 14:49:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: God <atm@pinky.penguinpowered.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stable Version?
In-Reply-To: <Pine.LNX.4.21.0103011008550.918-100000@scotch.homeip.net>
Message-ID: <Pine.LNX.4.33.0103011447350.1961-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, God wrote:

> What version of the 2.4.x kernels is actually stable enough to
> use?  I ask this because I see 2.4.2, but then the 2.4.2ac7 fix
> which from what I have read on here, is a pretty important
> patch.  Is 2.4.2 or 2.4.1 stable enough?
>
> I don't run a large site, but what I do have, I think would
> benefit very much from the improved 2.4.x kernel over what I
> have mostly have now, of 2.2.16's and 2.2.18's (if not for the
> the network stuff alone).

It all depends on exactly what you are doing.

I suspect that for most "normal" situations, 2.4 should be
pretty stable.

There are, however, a few areas where we still have bugs:
- loop device driver (fixed in -ac?)
- highmem (fixed in -ac?)
- SMP (detection, fixed ??)
- IPX
- NFS (fixed in -ac?)

I suspect we'll be finding a few more over the next weeks,
but if you're just using your machine as a webserver and
are not using anything special (ie. just ext2, tcp/ip, etc.)
2.4 should be solid.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

