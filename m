Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbRFQV3u>; Sun, 17 Jun 2001 17:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbRFQV3k>; Sun, 17 Jun 2001 17:29:40 -0400
Received: from [193.132.149.202] ([193.132.149.202]:58377 "EHLO uk2.imdb.com")
	by vger.kernel.org with ESMTP id <S262923AbRFQV3d>;
	Sun, 17 Jun 2001 17:29:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15149.8347.53385.459803@jim.imdb.com>
Date: Sun, 17 Jun 2001 22:26:50 +0100 (BST)
From: Jim Randell <jim@imdb.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug 2.4.{4,5} page_alloc.c:81
In-Reply-To: <15148.32506.916604.938393@jim.imdb.com>
In-Reply-To: <15148.32506.916604.938393@jim.imdb.com>
X-Mailer: VM 6.75 (21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid)
X-Missile-Address: 51 28 19 N / 02 35 41 W
X-Location: Bristol, UK
X-Face: 0i`dE&Q3d44YB<DfXUCR]+^L}0EAY(Lt}o%)3jE>g|yj*y0)|\a8KVbOdmkhW3Fgqy#oM1]JIV9VEO3$";)>8dpa}P8,R{(1<czOX27o7bK]q#GuwMpD2pgV4xj1\kUTVUo]ROa%aoNV,;.$P$@s#zuzpzw5B$KFYV)#5Cb1o8a&v$!gBRR;b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Randell writes:
> I've recently been getting strange system lock-ups - often my system
> just dies, but occasionally I get messages in dmesg. I've tried to
> isolate the problem by increasing the available swap (I now have > 2x
> RAM), removing my reiserfs partitions (I'm now running with ext2) and
> downgrading from kernel 2.4.5 to 2.4.4, but I'm still seeing the
> problem.

I think I've tracked this problem down to the D-Link DFE-530TX network
card, via-rhine driver and SMP (at least I've removed the card and put
the box through it's paces and not managed to get the problem to
recur).

-- 
Jim Randell  //  jim@imdb.com  //  +44.117.944.4227
http://www.imdb.com/       Mobile: +44.779.087.6488
                                                 :d
