Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSD0Ufa>; Sat, 27 Apr 2002 16:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSD0Uf2>; Sat, 27 Apr 2002 16:35:28 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:6133 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314548AbSD0UfC>; Sat, 27 Apr 2002 16:35:02 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 27 Apr 2002 14:32:51 -0600
To: Witek Krjcicki <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 fs corruption on 2.5.10
Message-ID: <20020427203251.GM16982@turbolinux.com>
Mail-Followup-To: Witek Krjcicki <adasi@kernel.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <001501c1ee23$98c57cf0$0201a8c0@witek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 27, 2002  21:41 +0200, Witek Krjcicki wrote:
> At first kernel hanged while calling hdparm, after removing hdparm from rc
> scripts, it hangs while remounting rootfs read-write. After that, partition
> is totally screwed up. All parts (ide, ext2) compiled as modules.
> It's reproductible but I'm unable to reproduce it since I'm cutted out from
> my Linux partition

Sounds like hdparm was trying to set IDE DMA modes to something bad,
and/or you have an IDE chipset problem, and that is the cause of the
corruption.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

