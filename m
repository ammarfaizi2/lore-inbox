Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSGOQD0>; Mon, 15 Jul 2002 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGOQDZ>; Mon, 15 Jul 2002 12:03:25 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:31228 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315406AbSGOQDY>; Mon, 15 Jul 2002 12:03:24 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 15 Jul 2002 10:03:57 -0600
To: Sam Vilain <sam@vilain.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dax@gurulabs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715160357.GD442@clusterfs.com>
Mail-Followup-To: Sam Vilain <sam@vilain.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, dax@gurulabs.com,
	linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17U4YE-0000TL-00@hofmann>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2002  13:02 +0100, Sam Vilain wrote:
>    "Yes, we know that there is no directory hashing in ext2/3.  You'll
> have to find another solution to the problem, I'm afraid.  Why not ease
> the burden on the filesystem by breaking up the task for it, and giving
> it to it in small pieces.  That way it's much less likely to choke."

Amusingly, there IS directory hashing available for ext2 and ext3, and
it is just as fast as reiserfs hashed directories.  See:

   http://people.nl.linux.org/~phillips/htree/paper/htree.html

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

