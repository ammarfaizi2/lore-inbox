Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283569AbRK3InN>; Fri, 30 Nov 2001 03:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283567AbRK3InD>; Fri, 30 Nov 2001 03:43:03 -0500
Received: from ebola.baana.suomi.net ([213.139.166.70]:63238 "EHLO
	ebola.baana.suomi.net") by vger.kernel.org with ESMTP
	id <S283565AbRK3Im4>; Fri, 30 Nov 2001 03:42:56 -0500
Date: Fri, 30 Nov 2001 10:37:49 +0200 (EET)
From: janne <sniff@xxx.ath.cx>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
cc: linux-kernel@vger.kernel.org, M G Berberich <berberic@fmi.uni-passau.de>
Subject: Re: 2.4.16: hda9: attempt to access beyond end of device
In-Reply-To: <200111292212.fATMCoo08605@enterprise.bidmc.harvard.edu>
Message-ID: <Pine.LNX.4.10.10111301027190.31853-100000@ebola.baana.suomi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 29 November 2001 04:58 pm, M G Berberich wrote:
> > Partition boundary problem in 2.4.16 ?!
> > I just tried to make a mke2fs on my /dev/hda9 and mke2fs with kernel
> > 2.4.16 and it failed with a partial write. /var/log/messages says:

i recently got some of these messages about "attempt to access beyond
end of device" when running badblocks on a partition, on 2.4.15-pre1.
i got two of them, and in the end badblocks said it found 2 bad blocks.
partitions were made with fdisk.
i don't know if it's normal or not, but bothers a little still. mke2fs
went through without errors and haven't noticed any corruption so far.


janne.

