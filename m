Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSGQTBj>; Wed, 17 Jul 2002 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSGQTBj>; Wed, 17 Jul 2002 15:01:39 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:32756 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316210AbSGQTBj>; Wed, 17 Jul 2002 15:01:39 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 17 Jul 2002 13:02:59 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020717190259.GA31503@clusterfs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717114501.GB28284@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 17, 2002  13:45 +0200, Matthias Andree wrote:
> On Tue, 16 Jul 2002, Shawn wrote:
> > In this case, can you use a RAID mirror or something, then break it?
> > 
> > Also, there's the LVM snapshot at the block layer someone already
> > mentioned, which when used with smaller partions is less overhead.
> > (less FS delta)
> 
> All these "solutions" don't work out, I cannot remount R/O my partition,
> and LVM low-level snapshots or breaking a RAID mirror simply won't work
> out. I would have to remount r/o the partition to get a consistent image
> in the first place, so the first step must fail already...

Have you been reading my emails at all?  LVM snapshots DO ensure that
the snapshot filesystem is consistent for journaled filesystems.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

