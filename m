Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275059AbTHGFCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275062AbTHGFCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:02:38 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:40957 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S275059AbTHGFCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:02:37 -0400
Date: Wed, 6 Aug 2003 23:02:20 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030806230220.I7752@schatzie.adilger.int>
Mail-Followup-To: Vladimir Lazarenko <vlad@lazarenko.net>,
	linux-kernel@vger.kernel.org
References: <200308070305.51868.vlad@lazarenko.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308070305.51868.vlad@lazarenko.net>; from vlad@lazarenko.net on Thu, Aug 07, 2003 at 03:05:51AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 07, 2003  03:05 +0200, Vladimir Lazarenko wrote:
> Is there going to be some kind of a converter for new reiserfs version?
> I'm running 2.4.22-rc1 now, with its current reiserfs implementation, and I 
> heard many good things about reiserfs v4, would it be possible to convert 
> filesystems without data loss? 
> 
> It's going to be a major pain if I'll have to back things up and reinitialize 
> partitions...

Why do people ever want a "converter"?

If you are converting your current filesystem to an _experimental_
filesystem, wouldn't you want to have a backup in case the new filesystem
had a bug in it?

Considering that such a conversion tool would be used only very rarely,
wouldn't you want to make a backup in case the conversion tool was broken?

The safest conversion is to make a backup with tar or similar, and then
restore it after a formatting the new filesystem.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

