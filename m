Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUDESdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDESdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:33:51 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:50145 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263124AbUDESdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:33:50 -0400
Date: Mon, 5 Apr 2004 09:17:23 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?Vladim=EDr_T=F8ebick=FD?= <druid@mail.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem strangeness (ext3)
Message-ID: <20040405151723.GC19054@schnapps.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?Vladim=EDr_T=F8ebick=FD?= <druid@mail.cz>,
	linux-kernel@vger.kernel.org
References: <1014938126.20040405120812@xhost.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1014938126.20040405120812@xhost.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 05, 2004  12:08 +0200, Vladimír Tøebický wrote:
> Error while iterating over blocks in inode 523442: Illegal triply indirect block found
> Segmentation fault
> 
> Linux master 2.4.22 #1 Sat Sep 20 14:26:11 CEST 2003 i686 unknown
> e2fsck 1.27 (8-Mar-2002)
>         Using EXT2FS Library version 1.27, 8-Mar-2002
> The device is /dev/md1:

Best to get newer version of e2fsck and try again.  Latest released version
of e2fsprogs is 1.35.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

