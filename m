Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319657AbSH3TXm>; Fri, 30 Aug 2002 15:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319658AbSH3TXm>; Fri, 30 Aug 2002 15:23:42 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:3325 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319657AbSH3TXl>; Fri, 30 Aug 2002 15:23:41 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 30 Aug 2002 13:25:49 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
Message-ID: <20020830192549.GB32468@clusterfs.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain> <3D6FC178.CC3E89CD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6FC178.CC3E89CD@zip.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2002  12:03 -0700, Andrew Morton wrote:
> Jani Monoses wrote:
> > 
> > This turns the remaining parts of ext3 to EXT3_SB and turns the latter
> > from a macro to inline function which returns the generic_sbp field of u.
> 
> Thanks.
> 
> It's not going to make the merge of all Stephen's 2.4 changes
> any more fun though ;)

It would probably be good if we did the back-port of the EXT3_SB and
EXT3_I changes to 2.4 to keep them in sync.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

