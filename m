Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSJYUsw>; Fri, 25 Oct 2002 16:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbSJYUsw>; Fri, 25 Oct 2002 16:48:52 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23239 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261600AbSJYUsv>; Fri, 25 Oct 2002 16:48:51 -0400
Subject: Re: KT333, IO-APIC, Promise Fasttrak, Initrd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: freaky <freaky@bananateam.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <007501c27c5d$378aef10$1400a8c0@Freaky>
References: <007501c27c5d$378aef10$1400a8c0@Freaky>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 22:11:39 +0100
Message-Id: <1035580299.13244.82.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 20:32, freaky wrote:
> it in IDE mode so I tricked it. Attached the harddisks one by one so arrays
> were created of one disk each. This works under WinXP. Most of the
> partitions were created on my previous system with PIIX intel controllers
> and are read without probs under XP.

Thats still going to have strange raid blocks on it. However if you then
partitioned the driver you should have blown it away with luck.

> The RAID controller comes up with both hd[e-h] and d<x>p<y>'s. Can I use the
> hd[e-h]'s? since I have 1 disk arrays?

hde/f/g/h are the real disks as a normal controller would see them. The
ataraid devices are interpreting a subset (the bits we know about) of
the raid partitioning the promise does

> Tried booting into my old partitions with the hdg3 but came up with IO
> errors. I'm guessing it has to do with the south bridge not being supported
> or the ext 2 partitions having trouble with being on the raid controller.

Need more details. Exact error messages matter here


