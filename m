Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJ0WsN>; Sun, 27 Oct 2002 17:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJ0WsG>; Sun, 27 Oct 2002 17:48:06 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:29195 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S262708AbSJ0Wri>;
	Sun, 27 Oct 2002 17:47:38 -0500
Date: Sun, 27 Oct 2002 14:53:46 -0800
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Pauses in 2.5.44 (some kind of memory policy change?)
Message-ID: <20021027225345.GA16431@netnation.com>
References: <200210272127.NAA03536@adam.yggdrasil.com> <3DBC5DC3.8641A66C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBC5DC3.8641A66C@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 01:42:27PM -0800, Andrew Morton wrote:

> "Adam J. Richter" wrote:
> >...
> >  3  0  2      0   9196  31420 178172    0    0     0 17152 6939   259  3 97  0
> >  1  0  1      0   2452  31420 185112    0    0     0  4056 4061   278  9 91  0
> 
> Sorry, don't know.
> 
> It's possible that your X server got paged out, but the system
> doesn't seem to be under any sort of stress, and there's not
> much page reclaim happening and no evidence of executable pagein.
> 
> I'm assuming that everything is on local disks apart from that
> mail file.  Really, you haven't told me much.  What's all that
> `bo' activity there?  What filesystems are in use?

The "bi" and "bo" are accidentally reversed in the kernel. :)
I can't believe nobody else has noticed this.

(I'm pretty sure I checked that vmstat was not reversing them.  The
numbers in /proc/vmstat were backwards...)

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
