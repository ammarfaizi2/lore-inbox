Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281052AbRKGXUW>; Wed, 7 Nov 2001 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKGXUN>; Wed, 7 Nov 2001 18:20:13 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:15612 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281052AbRKGXUC>;
	Wed, 7 Nov 2001 18:20:02 -0500
Date: Wed, 7 Nov 2001 16:18:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107161847.Q5922@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au>, <3BE9AF15.50524856@zip.com.au> <20011107142750.A545@mikef-linux.matchmail.com> <3BE9BC12.6E1A6295@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BE9BC12.6E1A6295@zip.com.au>; from akpm@zip.com.au on Wed, Nov 07, 2001 at 02:56:18PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  14:56 -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > Does that work for non-root ext3 mounts also?  ie, will ext3 default to
> > data=journaled mode for future mounts?
> 
> Nope.  You specify the option to other filesystems in /etc/fstab.

Maybe it should be possible to specify the journaling mode in the journal
superblock?  A mount option would override it, but it would at least set
the default mode.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

