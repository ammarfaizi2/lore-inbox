Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTBDU2C>; Tue, 4 Feb 2003 15:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBDU2B>; Tue, 4 Feb 2003 15:28:01 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:45556 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267457AbTBDU2B>; Tue, 4 Feb 2003 15:28:01 -0500
Date: Tue, 4 Feb 2003 13:37:27 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cleanup of filesystems menu
Message-ID: <20030204133727.T18636@schatzie.adilger.int>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302041512090.16603-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302041512090.16603-100000@dell>; from rpjday@mindspring.com on Tue, Feb 04, 2003 at 03:14:11PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 04, 2003  15:14 -0500, Robert P. J. Day wrote:
> 
>   randy dunlap was gracious enough to post my proposed
> patch to clean up the filesystems config menu.  the patch
> (80K uncompressed) is online at;
> 
>   http://www.xenotime.net/linux/kconfig/kconfig-fs-2.5.59b.patch
> 
> currently, it still has leading asterisks in front of the
> config entries to support editing in emacs outline mode, 
> but future patches will have these removed.
> 
>   it should patch cleanly against stock 2.5.59.
> 
>   comments?

Only a couple of minor ones - you don't need to have ext2 enabled in the
kernel if you use ext3 exclusively.  You should change the "if you have
your root filesystem as ext3 ... may be dangerous" wording to something
more like "if you use ext3 for your root filesystm you should not compile
this as a module", because _lots_ of people do that and then complain on
ext3-users...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

