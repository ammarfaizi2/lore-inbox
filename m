Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279676AbRJYBuV>; Wed, 24 Oct 2001 21:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279677AbRJYBuL>; Wed, 24 Oct 2001 21:50:11 -0400
Received: from peace.netnation.com ([204.174.223.2]:65292 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S279676AbRJYBtw>; Wed, 24 Oct 2001 21:49:52 -0400
Date: Wed, 24 Oct 2001 18:50:26 -0700
From: Simon Kirby <sim@netnation.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011024185026.B12118@netnation.com>
In-Reply-To: <Pine.LNX.4.21.0110241225560.2593-100000@freak.distro.conectiva> <dnlmi0pnue.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <dnlmi0pnue.fsf@magla.zg.iskon.hr>; from zlatko.calusic@iskon.hr on Thu, Oct 25, 2001 at 02:25:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 02:25:45AM +0200, Zlatko Calusic wrote:

> Sure. Output of 'vmstat 1' follows:
>...
>  0  2  0      0  43148   5328 389516   0   0     0  9548  174    97 0   4  95
>  0  2  0      0  35144   5336 397316   0   0     0  7820  176    73 0   3  97
>  0  2  0      0  25172   5344 407036   0   0     0  9724  188   183 0   4  96
>  0  2  1      0  17300   5352 414708   0   0     0  7744  174    78 0   4  96
>...
> Notice how there's planty of RAM. I'm writing sequentially to a file
> on the ext2 filesystem. The disk I'm writing on is a 7200rpm IDE,
> capable of ~ 22 MB/s and I'm still getting only ~ 9 MB/s. Weird!

Same here.  But hey, at least it doesn't swap now! :)

Also, dd if=/dev/zero of=blah bs=1024k seems to totally kill everything
else on my box until I ^C it.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
