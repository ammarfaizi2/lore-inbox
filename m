Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283591AbRLIQUz>; Sun, 9 Dec 2001 11:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283618AbRLIQUq>; Sun, 9 Dec 2001 11:20:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48399 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283661AbRLIQUf>; Sun, 9 Dec 2001 11:20:35 -0500
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 9 Dec 2001 16:29:00 +0000 (GMT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112082012330.1344-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 08, 2001 08:19:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16D6p2-00074U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Remember: we'd save 15*4=60 bytes per inode, at the cost of pinning the
> block the inode is in. But _usually_ we'd have those blocks in memory
> anyway, especially if the inode gets touched (which dirties it, and
> updates atime, which forces us to do writeback). For the initial IO we
> obviously _have_ to have them in memory.

Surely the buffer has the on disk inode format, not the fast to handle
in processor inode format ?

Alan
