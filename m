Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTBLK3g>; Wed, 12 Feb 2003 05:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTBLK3g>; Wed, 12 Feb 2003 05:29:36 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:64423 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S266991AbTBLK3f>;
	Wed, 12 Feb 2003 05:29:35 -0500
Date: Wed, 12 Feb 2003 11:39:14 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       bernard@biesterbos.nl, ext2-devel@lists.sourceforge.net
Subject: Re: raid5 2TB+ NO GO ?
In-Reply-To: <15945.31516.492846.870265@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.53.0302121129480.13462@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302060059210.6169@ddx.a2000.nu>
 <Pine.LNX.4.53.0302060123150.6169@ddx.a2000.nu> <Pine.LNX.4.53.0302060211030.6169@ddx.a2000.nu>
 <15937.50001.367258.485512@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.53.0302061915390.17629@ddx.a2000.nu>
 <15945.31516.492846.870265@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Peter Chubb wrote:

> >>>>> "Stephan" == Stephan van Hienen <raid@a2000.nu> writes:
>
> Stephan,
> 	Just noticed you're using raid5 --- I don't believe that level
> 5 will work, as its data structures and  internal algorithms are
> 32-bit only.  I've done no work on it to make it work (I've been
> waiting for the rewrite in 2.5), and don't have time to do anything now.
>
> You could try making sector in the struct stripe_head a sector_t, but
> I'm pretty sure you'll run into other problems.
>
> I only managed to get raid 0 and linear to work when I was testing.

ok clear, so no raid5 for 2TB+ then :(

looks like i have to remove some hd's then

what will be the limit ?

13*180GB in raid5 ?
or 12*180GB in raid5 ?

    Device Size : 175823296 (167.68 GiB 180.09 GB)

13* will give me 1,97TiB but will there be an internal raid5 problem ?
(since it will be 13*180GB to be adressed)


