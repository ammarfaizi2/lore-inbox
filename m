Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTBFVtQ>; Thu, 6 Feb 2003 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTBFVtQ>; Thu, 6 Feb 2003 16:49:16 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:29934 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267459AbTBFVtP>; Thu, 6 Feb 2003 16:49:15 -0500
Date: Thu, 6 Feb 2003 14:14:15 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Thomas Molina <tmolina@cox.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-ID: <20030206141415.J18636@schatzie.adilger.int>
Mail-Followup-To: Thomas Molina <tmolina@cox.net>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030206123631.617524f7.akpm@digeo.com> <Pine.LNX.4.44.0302061501510.998-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302061501510.998-100000@localhost.localdomain>; from tmolina@cox.net on Thu, Feb 06, 2003 at 03:05:11PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06, 2003  15:05 -0600, Thomas Molina wrote:
> On Thu, 6 Feb 2003, Andrew Morton wrote:
> > Everything you describe is consistent with a kernel which does not have ext3
> > compiled into it.
> > 
> > That is an ext3 filesystem in the "needs journal recovery" state.  ext2
> > cannot mount that until either fsck or the ext3 kernel driver has run
> > recovery.
> 
> I'm aware of that.  I attached the config file showing ext3 was compiled 
> in.  I went through several iterations to ensure that having the proper 
> filesystem compiled in was done.  

Maybe some config/linking breakage puts ext2 in front of ext3 in the probe
order?  Try compiling with ext2 as a module.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

