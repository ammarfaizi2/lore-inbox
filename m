Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291677AbSBHRsY>; Fri, 8 Feb 2002 12:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291678AbSBHRsO>; Fri, 8 Feb 2002 12:48:14 -0500
Received: from [63.231.122.81] ([63.231.122.81]:64830 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291677AbSBHRsE>;
	Fri, 8 Feb 2002 12:48:04 -0500
Date: Fri, 8 Feb 2002 10:47:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Peter H. R|egg" <pruegg@eproduction.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with mke2fs on huge RAID-partition
Message-ID: <20020208104739.M15496@lynx.turbolabs.com>
Mail-Followup-To: "Peter H. R|egg" <pruegg@eproduction.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C640C90.E71E3F70@eproduction.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C640C90.E71E3F70@eproduction.ch>; from pruegg@eproduction.ch on Fri, Feb 08, 2002 at 06:36:16PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 08, 2002  18:36 +0100, Peter H. R|egg wrote:
> My problem is: If I start mke2fs [1] on the device, it writes everything
> down until "Writing Superblocks...". The system then completly hangs.
> And yes, I did wait long enough (well, at least I think 15 hours should
> be enough ;-)
> 
> Is there a limitation in the maximum size of a partition (well, 400 GB is
> not that small...), may it be a (known) problem of mke2fs or the particular
> Kernel-Version, or does anyone have any suggestions where else to seek?

Well, I know for a fact that people have created such large ext2 filesystems.

> All RAID is done in software, using (at the moment) a Standard RedHat 7.2
> Kernel 2.4.7.

The first thing to do would be to update to the latest RH kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

