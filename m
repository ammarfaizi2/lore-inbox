Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263166AbSJBQvu>; Wed, 2 Oct 2002 12:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbSJBQvu>; Wed, 2 Oct 2002 12:51:50 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:16381 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263166AbSJBQvc>; Wed, 2 Oct 2002 12:51:32 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 2 Oct 2002 10:54:54 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021002165454.GV3000@clusterfs.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021002104859.GD6318@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002104859.GD6318@stingr.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2002  14:48 +0400, Paul P Komkoff Jr wrote:
> Unfortunately, there still one issue in ext3. It called "inode limit".
> Initially I wanted to run this test on 1000000 files but ... I hit
> inode limit and don't want to increase it artificially yet.
> 
> Reiserfs worked fine because it don't have such kind of limit ...

We have plans to fix this already, but it is not high enough on anyones
priority list quite yet (most filesystems have enough inodes for regular
usage).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

