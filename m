Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132521AbRA2QBs>; Mon, 29 Jan 2001 11:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRA2QBi>; Mon, 29 Jan 2001 11:01:38 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:48730 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S132521AbRA2QB1>;
	Mon, 29 Jan 2001 11:01:27 -0500
Date: Mon, 29 Jan 2001 09:01:32 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
In-Reply-To: <3A75278F.B41B492B@bigfoot.com>
Message-ID: <Pine.LNX.4.31.0101290856370.31743-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Datapoint

I have a chaintech 7AIA KT133-based TB motherboard.  I use a USB mouse so
I can't verify #1.  However it(2.4.0-release) autodetects all my memory
and I don't see a big enough clock drift even with 100% cpu utilization
(don't know about high disk utilization though)

Are you sure you don't have OS/2 mode or memory hole enabled in bios?  Not
sure if it matters but it could...  Also USB mouse support, make sure it's
disabled in BIOS?  Just guessing some things to look at.

-bc

On Mon, 29 Jan 2001, Dylan Griffiths wrote:

> Date: Mon, 29 Jan 2001 02:19:27 -0600
> From: Dylan Griffiths <Dylan_G@bigfoot.com>
> To: Linux kernel <linux-kernel@vger.kernel.org>
> Subject: More on the VIA KT133 chipset misbehaving in Linux
>
> The VIA KT133 chipset exhibits the following bugs under Linux 2.2.17 and
> 2.4.0:
> 1) PS/2 mouse cursor randomly jumps to upper right hand corner of screen and
> locks for a bit
> 2) Detects a maximum of 64mb of ram, unless worked around by the "mem="
> switch
> 3) The clock drifts slowly (more so under heavy load than light load),
> leaking time.
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
