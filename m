Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129671AbRBFRwq>; Tue, 6 Feb 2001 12:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRBFRwg>; Tue, 6 Feb 2001 12:52:36 -0500
Received: from dsl-45-165.muscanet.com ([208.164.45.165]:53172 "EHLO grace")
	by vger.kernel.org with ESMTP id <S129671AbRBFRwS>;
	Tue, 6 Feb 2001 12:52:18 -0500
Date: Tue, 6 Feb 2001 11:51:15 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
In-Reply-To: <E14Q9U2-0005gX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102061147590.27615-100000@grace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 6 Feb 2001, Alan Cox wrote:

[snip]

> In theory for a journalling file system it means the change is committed to the
> log and the log to the media, and for other fs that the change is committed
> to the final disk and recoverable by fsck worst case
> 
> In practice some IDE disks do write merging and small amounts of write
> caching in the drive firmware so you cannot trust it 100%. In addition some
> higher end controllers will store to battery backed memory caches which is
> normally just fine since the reboot will play through the ram cache.
> 

Does this imply that in order to ensure my data hits the drives, i should
do a warm reboot and then shut down from the lilo: prompt or similiar?

apologies to bug you with a simple question, but i can see other people
worrying about data loss here too.

--
/jbm

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
