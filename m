Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130227AbRBWMwZ>; Fri, 23 Feb 2001 07:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWMwQ>; Fri, 23 Feb 2001 07:52:16 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:27405 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S130227AbRBWMv5>; Fri, 23 Feb 2001 07:51:57 -0500
Date: Fri, 23 Feb 2001 12:51:53 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 under heavy network load - more info
In-Reply-To: <Pine.LNX.4.31.0102212031240.21127-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0102231247300.9832-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Feb 2001, Rik van Riel wrote:

> I'm really interested in things which make Linux 2.4 break
> performance-wise since I'd like to have them fixed before the
> distributions start shipping 2.4 as default.

Hi Rik,

With kernel 2.4.1, I found that caching is way too aggressive. I was
running konqueror in 32Mb (the quest for a lightwieght browser!)
Unfortunately, the system seemed to insist on keeping 16Mb used for
caches, with 15Mb given to the application and X. This led to a lot of
swapping and paging by konqueror. I think the browser would be fully
usable in 32Mb, were the caching not out of balance.

Cheers
Chris

