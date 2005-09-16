Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbVIPOOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbVIPOOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 10:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVIPOOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 10:14:47 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:5791 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1161056AbVIPOOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 10:14:47 -0400
Date: Fri, 16 Sep 2005 16:14:45 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.1 Slab corruption during boot
Message-ID: <20050916141445.GA32693@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stock 2.6.13.1 on a P4 with HT:

...
Sep 16 16:02:00 espoo kernel: arp_tables: (C) 2002 David S. Miller
Sep 16 16:02:00 espoo kernel: TCP bic registered
Sep 16 16:02:01 espoo kernel: TCP westwood registered
Sep 16 16:02:01 espoo kernel: TCP highspeed registered
Sep 16 16:02:01 espoo kernel: TCP hybla registered
Sep 16 16:02:01 espoo kernel: TCP htcp registered
Sep 16 16:02:01 espoo kernel: TCP vegas registered
Sep 16 16:02:01 espoo kernel: TCP scalable registered
Sep 16 16:02:01 espoo kernel: NET: Registered protocol family 1
Sep 16 16:02:01 espoo kernel: NET: Registered protocol family 17
Sep 16 16:02:01 espoo kernel: Starting balanced_irq
Sep 16 16:02:01 espoo kernel: Using IPI Shortcut mode
Sep 16 16:02:01 espoo kernel: md: Autodetecting RAID arrays.
Sep 16 16:02:01 espoo kernel: md: autorun ...
Sep 16 16:02:01 espoo kernel: md: ... autorun DONE.
Sep 16 16:02:01 espoo kernel: kjournald starting.  Commit interval 5 seconds
Sep 16 16:02:01 espoo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 16 16:02:01 espoo kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep 16 16:02:01 espoo kernel: Freeing unused kernel memory: 252k freed
Sep 16 16:02:01 espoo kernel: EXT3 FS on sda2, internal journal
Sep 16 16:02:01 espoo kernel: Adding 1004052k swap on /dev/sda1.  Priority:-1 extents:1
Sep 16 16:02:01 espoo kernel: program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
Sep 16 16:02:01 espoo last message repeated 3 times
Sep 16 16:02:01 espoo kernel: kjournald starting.  Commit interval 5 seconds
Sep 16 16:02:01 espoo kernel: EXT3 FS on sda4, internal journal
Sep 16 16:02:01 espoo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 16 16:02:01 espoo kernel: Slab corruption: start=f7f31000, len=4096
Sep 16 16:02:01 espoo kernel: 0b0: 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff 00 00 00 00
Sep 16 16:02:01 espoo kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Sep 16 16:02:01 espoo kernel: tg3: eth0: Flow control is on for TX and on for RX.
Sep 16 16:02:01 espoo ypbind: bound to NIS server xxx
Sep 16 16:02:01 espoo rc: Starting pcmcia:  succeeded
Sep 16 16:02:01 espoo netfs: Mounting NFS filesystems:  succeeded
Sep 16 16:02:01 espoo netfs: Mounting other filesystems:  succeeded
Sep 16 16:02:01 espoo identd: identd startup succeeded
Sep 16 16:02:02 espoo sshd:  succeeded


-- 
Frank
