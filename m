Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTH1DBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 23:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTH1DBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 23:01:31 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:56985 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S263730AbTH1DBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 23:01:30 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308280259.h7S2xFKV031299@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <Pine.LNX.4.53.0308271123480.659@chaos>
To: root@chaos.analogic.com
Date: Thu, 28 Aug 2003 04:59:14 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> With your NVRAM drive, it is likely that the drive parameters
> are 'protected' by a partition table. If you overwrite this
> partition table, the drive becomes broken. This means that,
> whatever you do, you can't modify some important portion
> of that table.

the contradiction to this is that the flashdisk can be used
in a "partition-less" state where it is possible to use the
whole device at one: "mke2fs /dev/sdb". you have to use the
vendor formating-tool to make the flashdisk look like an USB_FDD
device. but even in USB_HDD mode with partitions, the partitions
still look strange, not ending on cylinder boundaries and so on.

oh my. I guess I gonna contact Panram then and of course,
thanks for the URL to the USB-snoop utility.

thx
h.rosmanith

