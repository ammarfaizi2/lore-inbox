Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTJCL71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 07:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTJCL71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 07:59:27 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5505 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263720AbTJCL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 07:59:11 -0400
Date: Fri, 3 Oct 2003 12:59:41 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310031159.h93BxfYm000758@81-2-122-30.bradfords.org.uk>
To: Erik Bourget <erik@midmaine.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87brsybm41.fsf@loki.odinnet>
References: <87brsybm41.fsf@loki.odinnet>
Subject: Re: CMD680, kernel 2.4.21, and heartache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some factors that are definitely NOT a problem:
> - Faulty run of drives.  This has also happened to Hitachi 80GB drives in the
>   same configurations.
> 
> - Heat.  They're in a chilly room.  The cases haven't overheated.  We've had
>   guys checking this every few hours after the first one went bonkers.
> 
> Possible problems -
> - Simple software problem that somebody can fix and save the day. :)
> - All Dell Poweredge 650 servers are broken.  :/

> Oct  1 07:47:47 mailstore2-1 kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Oct  1 07:47:47 mailstore2-1 kernel: hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=37694874, high=2, low=4140442, sector=35220864

That is definitely an error from the drive.  If you're absolutely sure
it's not a faulty batch of drives or a cooling issue, maybe you have
power supply problems?  Does SMART give you any useful information?

John.
