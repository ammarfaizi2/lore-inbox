Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSHZWAN>; Mon, 26 Aug 2002 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSHZWAN>; Mon, 26 Aug 2002 18:00:13 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:33013 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318295AbSHZWAM>; Mon, 26 Aug 2002 18:00:12 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 26 Aug 2002 16:02:38 -0600
To: Yedidyah Bar-David <didi@tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updating the partition table of a busy drive
Message-ID: <20020826220238.GE19435@clusterfs.com>
Mail-Followup-To: Yedidyah Bar-David <didi@tau.ac.il>,
	linux-kernel@vger.kernel.org
References: <20020827005254.A20617@soul.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827005254.A20617@soul.math.tau.ac.il>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 27, 2002  00:52 +0300, Yedidyah Bar-David wrote:
> Currently, any change to a partition table of a busy drive is
> practically delayed to the next reboot. Even things trivial as
> changing the type of an unmounted partition do not work, if
> another partition on that drive is mounted (or swapped to, etc.).
> 
> On a side note, about a year and a half ago, there was a thread
> on lkml with the subject 'Partition IDs in the New World TM', in
> which a 'parttab' file was mentioned. I grepped and STFWed a lot,
> and could not find any relevant mention anywhere, besides this
> thread. Is this parttab implemented? Documented? Perhaps under
> a different name? Is this case it is quite hard to find
> (google search for 'linux parttab' has 37 results, but for
> e.g. 'linux partition table initrd' 11400 results).

Please see partx (util-linux) and/or GNU parted for tools which can
change partitions on mounted disks.  I believe the kernel has supported
this since 2.4.0, but not many tools do.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

