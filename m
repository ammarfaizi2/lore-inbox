Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282282AbRKWXUd>; Fri, 23 Nov 2001 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282281AbRKWXUY>; Fri, 23 Nov 2001 18:20:24 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:18678 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282096AbRKWXUG>;
	Fri, 23 Nov 2001 18:20:06 -0500
Date: Fri, 23 Nov 2001 16:19:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Mike Eldridge <diz@cafes.net>
Cc: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
Message-ID: <20011123161947.E1308@lynx.no>
Mail-Followup-To: Mike Eldridge <diz@cafes.net>,
	Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com> <002801c1740f$7372f650$1300a8c0@marcelo> <20011123171157.Q21290@mail.cafes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011123171157.Q21290@mail.cafes.net>; from diz@cafes.net on Fri, Nov 23, 2001 at 05:11:57PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  17:11 -0600, Mike Eldridge wrote:
> ext2 has a 2GB filesize limitation.

Where do you get that idea from.  I have created files up to 4TB (sparse
ones, of course) without problems.  After that you start hitting bugs in
the VFS and ext2 _code_, but you should be able to have up to 16TB files
on a 4kB block ext2 fs.

Please stop spreading misinformation.  Maybe there is a 2GB limitation
in libc, or your tools, or in 2.2 ext2 _implementation_ (which is
fixed if you apply the LFS patch for ext2), but no such limit in the
design of ext2 itself.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

