Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310207AbSCKQpL>; Mon, 11 Mar 2002 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310205AbSCKQpC>; Mon, 11 Mar 2002 11:45:02 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:8944 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310202AbSCKQon>; Mon, 11 Mar 2002 11:44:43 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 11 Mar 2002 09:44:11 -0700
To: Erik Meusel <meusel@codixx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2/3 uid/gid support
Message-ID: <20020311164411.GA1873@turbolinux.com>
Mail-Followup-To: Erik Meusel <meusel@codixx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16j1Z6-0002xf-00@the-village.bc.nu> <02031109444400.00601@huschki> <20020311084741.GC311@matchmail.com> <02031110223301.00601@huschki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02031110223301.00601@huschki>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 11, 2002  10:22 +0100, Erik Meusel wrote:
> The reason why I ask is, I have two linux stations and I want to use ext2
> for the floppy disks to save space for fat vfat and so on. Now it would
> be nice to automatically mount my floppies with group "floppy", so that
> all the users, belonging to group "floppy", can read/write from/to disk.

You will find that:
a) FAT uses less space than ext2 on a floppy for the same amount of files
b) you don't need to mount a FAT floppy if you don't want (you can use
   mcopy/mdir/etc for quick operations)
c) you can read a FAT floppy from a Windows machine if needed

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

