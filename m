Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbTH1QUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTH1QUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:20:46 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:6043 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S264114AbTH1QUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:20:44 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308281618.h7SGIMMp014455@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <20030828154454.A2343@pclin040.win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Date: Thu, 28 Aug 2003 18:18:22 +0200 (MET DST)
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 28, 2003 at 04:59:14AM +0200, H.Rosmanith (Kernel Mailing List) wrote:
> 
> > the contradiction to this is that the flashdisk can be used
> > in a "partition-less" state where it is possible to use the
> > whole device at one: "mke2fs /dev/sdb". you have to use the
> > vendor formating-tool to make the flashdisk look like an USB_FDD
> > device. but even in USB_HDD mode with partitions, the partitions
> > still look strange, not ending on cylinder boundaries and so on.
> 
> I have seen several posts from you, but all in this vague, almost
> information-free style.

the information is vague, because I don't exactly know how I manage
to stop the drive working.
 
> It would be of interest if you described your actions and the results
> in detail. Or if you gave explicitly the partition table that you
> consider strange.

hm, that's not so easy. I notice that the drive stops working, but
I can't exactly tell when. Unfortunately I can't give you the
partition table of the new drive anymore, because it's alread gone ;-)

> [If you only think about cylinder boundaries: cylinders do not exist,
> and cylinder boundaries do not exist either. So that in itself does
> not mean a thing.]

well ... I would assume that a proper "emulation" of a harddisk by a
flashdrive would also look like a real harddisk, with correct
cylinder boundaries. But obviously, this is not the case. Should
I get a new drive, I will mail you the strange-looking partiotion-table:
it will look like "physical start at (0,3,3)" or similar.

best regards,
h.rosmanith

