Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287475AbSAHATu>; Mon, 7 Jan 2002 19:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287471AbSAHATd>; Mon, 7 Jan 2002 19:19:33 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:40692 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287475AbSAHATJ>;
	Mon, 7 Jan 2002 19:19:09 -0500
Date: Mon, 7 Jan 2002 17:17:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Message-ID: <20020107171739.M777@lynx.no>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Daniel Phillips <phillips@bonn-fries.net>, torvalds@transmeta.com,
	viro@math.psu.edu, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NcLw-0001R9-00@starship.berlin> <3C3A3341.F9025058@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3A3341.F9025058@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jan 07, 2002 at 06:46:09PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2002  18:46 -0500, Jeff Garzik wrote:
> I greatly prefer function pointers to [possibly] generic obj management
> code, to storing object sizes.  Some filesystem is inevitably going to
> want to do something even more clever with inode allocation.  My method
> gives developers the freedom to experiement with inode alloc to their
> heart's desires, without affecting any other filesystem.

Oh, I totally agree.  I think stacking filesystems will generally want to
be able to do their own inode-private allocation.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

