Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUA1JY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 04:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUA1JY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 04:24:29 -0500
Received: from cibs9.sns.it ([192.167.206.29]:53002 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265877AbUA1JY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 04:24:28 -0500
Date: Wed, 28 Jan 2004 10:24:14 +0100 (CET)
From: venom@sns.it
To: Christoph Hellwig <hch@infradead.org>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
In-Reply-To: <20040127205324.A19913@infradead.org>
Message-ID: <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004, Christoph Hellwig wrote:
>
> Yes, it does.  But JFS should get the right size from the gendisk anyway.
> Or did you create the raid with the filesystem already existant?  While that
> appears to work for a non-full ext2/ext3 filesystem it's not something you
> should do because it makes the filesystem internal bookkeeping wrong and
> you'll run into trouble with any filesystem sooner or later.
>
In most situation to create a new FS on a RAID1 MD is not an option.
It happens that you have to mirror a partition, maybe alarge one, and it
already had a filesystem on top of it. Then what should you do?
backup, mirror and then restore? Sometimes it is not possible this too.
Then you accept to deal with the possible problems...

Luigi

