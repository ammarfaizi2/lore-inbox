Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUA1Kyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbUA1Kyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 05:54:47 -0500
Received: from unthought.net ([212.97.129.88]:10381 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S265901AbUA1Kyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 05:54:46 -0500
Date: Wed, 28 Jan 2004 11:54:44 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: venom@sns.it
Cc: Christoph Hellwig <hch@infradead.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040128105444.GK814@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	venom@sns.it, Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Florian Huber <florian.huber@mnet-online.de>,
	JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040127205324.A19913@infradead.org> <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:24:14AM +0100, venom@sns.it wrote:
> 
> 
> On Tue, 27 Jan 2004, Christoph Hellwig wrote:
> >
> > Yes, it does.  But JFS should get the right size from the gendisk anyway.
> > Or did you create the raid with the filesystem already existant?  While that
> > appears to work for a non-full ext2/ext3 filesystem it's not something you
> > should do because it makes the filesystem internal bookkeeping wrong and
> > you'll run into trouble with any filesystem sooner or later.
> >
> In most situation to create a new FS on a RAID1 MD is not an option.
> It happens that you have to mirror a partition, maybe alarge one, and it
> already had a filesystem on top of it. Then what should you do?
> backup, mirror and then restore? Sometimes it is not possible this too.
> Then you accept to deal with the possible problems...

Read The Fine Manual.     :)

http://unthought.net/Software-RAID.HOWTO/Software-RAID.HOWTO-7.html#ss7.4

"Method 2" covers exactly this, for a root filesytem though, but you
should be able to adapt it.

 / jakob


