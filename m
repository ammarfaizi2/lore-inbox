Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSGCUVB>; Wed, 3 Jul 2002 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSGCUVA>; Wed, 3 Jul 2002 16:21:00 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:4849 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317117AbSGCUU6>; Wed, 3 Jul 2002 16:20:58 -0400
Date: Wed, 3 Jul 2002 14:21:07 -0600
From: Andreas Dilger <adilger@turbolinux.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: sct@redhat.com, Andrew Morton <akpm@zip.com.au>,
       LKML <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: EXT3-fs error on kernel 2.4.18-pre3
Message-ID: <20020703202107.GA14654@clusterfs.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cantab.net>, sct@redhat.com,
	Andrew Morton <akpm@zip.com.au>,
	LKML <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
References: <1025723138.3817.10.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025723138.3817.10.camel@storm.christs.cam.ac.uk>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 03, 2002  20:05 +0100, Anton Altaparmakov wrote:
> I just noticed that my file server running 2.4.18-pre3 + IDE patches &
> NTFS patches has this error message in the logs:
> 
> EXT3-fs error (device md(9,4)): ext3_free_blocks: Freeing blocks not in
> datazone - block = 33554432, count = 1
> 
> This is the only ext3 error I have seen and the uptime is currently over
> 74 days. The error actually appeared two weeks ago. The timing coincides
> well with when this device (/dev/md4, a MD RAID-1 array) ran out of
> space, so it may well be related.

This was fixed in newer kernels.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

