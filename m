Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315603AbSENKvI>; Tue, 14 May 2002 06:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSENKvH>; Tue, 14 May 2002 06:51:07 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:10485 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315603AbSENKvG>; Tue, 14 May 2002 06:51:06 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 14 May 2002 04:49:22 -0600
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 errors with 2.4.18
Message-ID: <20020514104922.GR12975@turbolinux.com>
Mail-Followup-To: Oliver Feiler <kiza@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CD6AE7A.FBEB5726@delusion.de> <200205141238.11104.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2002  12:38 +0200, Oliver Feiler wrote:
> On Monday 06 May 2002 18:25, Udo A. Steinberg wrote:
> > Hi,
> >
> > With Linux 2.4.18, I'm getting multiple of the following error:
> >
> > EXT3-fs error (device ide0(3,2)): ext3_readdir: bad entry in directory
> > #1966094: rec_len % 4 != 0 - offset=0, inode=3180611420, rec_len=53134,
> > name_len=138
> 
> Hi,
> 
> I experienced the same problem with ext3 + 2.4.18 on a RAID-1. Out of nowhere 
> the following error popped up in the syslog, no other surrounding error 
> messages. The fs was mounted read-only automatically. After reboot and fsck 
> there were /a lot/ of errors on the disk. Virtually all errors fsck knows I 
> think. :)  After fsck ran multiple times on the disk, lost+found was filled 
> with stuff from all accross the disk, but other than that the fs seems to 
> have survived it.

There have been several reports of strange ext3 errors when running on
MD RAID.  I don't know if anyone is looking into this yet.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

