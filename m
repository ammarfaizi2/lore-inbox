Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTA0SVJ>; Mon, 27 Jan 2003 13:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTA0SVI>; Mon, 27 Jan 2003 13:21:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24977 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267266AbTA0SVI>;
	Mon, 27 Jan 2003 13:21:08 -0500
Date: Mon, 27 Jan 2003 10:18:34 -0800 (PST)
Message-Id: <20030127.101834.09050196.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for fs/partitions/sun.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030127003011.B9530@devserv.devel.redhat.com>
References: <20030127003011.B9530@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Mon, 27 Jan 2003 00:30:11 -0500

   Boots with recent 2.5 greet me with this on the console:
   
   [/sbin/fsck.ext2] fsck.ext2 -a /dev/sda6
   fsck.ext2: Device not configured while trying to open /dev/sda6
   
   This happens because I have root on /dev/sda4 and /home on /dev/sda6.
   Dave, can you take it or should I send it to Trivial?

Yes, Viro added this bug in one of his cleanups.  And I just
continued the bug when I patched in the RAID auto-detect
support.

Applied, thanks.
