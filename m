Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSHZW5s>; Mon, 26 Aug 2002 18:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSHZW5s>; Mon, 26 Aug 2002 18:57:48 -0400
Received: from soul.math.tau.ac.il ([132.67.192.131]:55181 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id <S318283AbSHZW5r>;
	Mon, 26 Aug 2002 18:57:47 -0400
Date: Tue, 27 Aug 2002 02:02:01 +0300
From: Yedidyah Bar-David <didi@tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: updating the partition table of a busy drive
Message-ID: <20020827020201.A20702@soul.math.tau.ac.il>
References: <20020827005254.A20617@soul.math.tau.ac.il> <20020826220238.GE19435@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020826220238.GE19435@clusterfs.com>; from adilger@clusterfs.com on Mon, Aug 26, 2002 at 04:02:38PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 04:02:38PM -0600, Andreas Dilger wrote:
> On Aug 27, 2002  00:52 +0300, Yedidyah Bar-David wrote:
> > Currently, any change to a partition table of a busy drive is
> > practically delayed to the next reboot. Even things trivial as
> > changing the type of an unmounted partition do not work, if
> > another partition on that drive is mounted (or swapped to, etc.).
> > 
> > On a side note, about a year and a half ago, there was a thread
> > on lkml with the subject 'Partition IDs in the New World TM', in
> > which a 'parttab' file was mentioned. I grepped and STFWed a lot,
> > and could not find any relevant mention anywhere, besides this
> > thread. Is this parttab implemented? Documented? Perhaps under
> > a different name? Is this case it is quite hard to find
> > (google search for 'linux parttab' has 37 results, but for
> > e.g. 'linux partition table initrd' 11400 results).
> 
> Please see partx (util-linux) and/or GNU parted for tools which can
> change partitions on mounted disks.  I believe the kernel has supported
> this since 2.4.0, but not many tools do.

Thanks a lot! I am right off to adding a small note on my home
page for google searches to find. Tools help, but information
even more.
I tried partx and it works just fine. parted will probably be even
better, but is a bit more complicated (or so it seems).

> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/

Again, Thanks!

	Didi

