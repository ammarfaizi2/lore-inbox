Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbULPOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbULPOys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbULPOx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:53:56 -0500
Received: from web26502.mail.ukl.yahoo.com ([217.146.176.39]:4761 "HELO
	web26502.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262679AbULPOwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:52:30 -0500
Message-ID: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
Date: Thu, 16 Dec 2004 14:52:29 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: 3TB disk hassles
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy...

After much banging of heads on walls, I am throwing in the towel and
asking the experts ;-) ... To cut a long story short:

Is it possible to make a 3TB disk work properly in Linux?

Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware 9500-S12,
so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one and
only disk in the system.

Problems are arising due to the 32-bit-ness of normal partition tables.
 I can use parted to make a 2.7TB partition (sda4), and
/proc/partitions looks fine until a reboot, whereupon the top bits are
lost and the big partition looks like a 700GB partition instead of a
2.7TB one; this is a bad thing ;-)

I've had my hopes raised by GPT, but after more reading it appears this
doesn't work on vanilla x86 PCs.

Tips gratefully received.

Neil

PS: not on-list; I'll be reading the real-time archivers, but CCs of
any replies would be appreciated.


	
	
		
___________________________________________________________ 
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
