Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbTCGGiy>; Fri, 7 Mar 2003 01:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbTCGGiy>; Fri, 7 Mar 2003 01:38:54 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:18165 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261391AbTCGGix>; Fri, 7 Mar 2003 01:38:53 -0500
Date: Thu, 6 Mar 2003 23:48:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Corruption problem with ext3 and htree
Message-ID: <20030306234819.Q1373@schatzie.adilger.int>
Mail-Followup-To: Martin Schlemmer <azarah@gentoo.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030307063940.6d81780e.azarah@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030307063940.6d81780e.azarah@gentoo.org>; from azarah@gentoo.org on Fri, Mar 07, 2003 at 06:39:40AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07, 2003  06:39 +0200, Martin Schlemmer wrote:
> For some time now I have been having a problem with ext3 and htree.
> 
> I use Gentoo, with portage as package system.  My root is on ext3
> without htree, and my portage tmp/build directory is on another
> drive with ext3 and htree.
> 
> Now, when you install something, it unpacks and compile and then
> install it to the build root on the tmp partition (ext3 with htree),
> and then 'merge' it to / (ext3 without htree) from that build root.

There have been a number of ext3+htree fixes in the last week or so.
I'm not sure if all of them are in the kernel yet, but I think the -mm
tree will have the majority of them.  Please also see the ext2-devel
and ext3-users mailing list archives for the last week for the patches.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

