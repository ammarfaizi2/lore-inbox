Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRK1U5O>; Wed, 28 Nov 2001 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278808AbRK1U5E>; Wed, 28 Nov 2001 15:57:04 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:12020 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278120AbRK1U4z>;
	Wed, 28 Nov 2001 15:56:55 -0500
Date: Wed, 28 Nov 2001 13:56:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011128135611.D856@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	'lkml' <linux-kernel@vger.kernel.org>
In-Reply-To: <3C03FE2F.63D7ACFD@zip.com.au> <Pine.LNX.4.21.0111281604390.15571-100000@freak.distro.conectiva> <3C054992.48F5C9E7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C054992.48F5C9E7@zip.com.au>; from akpm@zip.com.au on Wed, Nov 28, 2001 at 12:31:14PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2001  12:31 -0800, Andrew Morton wrote:
> write-cluster.patch
> 	ext2 metadata prereading and various other hacks which
> 	prevent writes from stumbling over reads, and thus ruining
> 	write clustering.  This patch is in the early prototype stage

Shouldn't the ext2_inode_preread() code use "ll_rw_block(READ_AHEAD,...)"
just to be proper?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

