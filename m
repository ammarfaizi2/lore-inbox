Return-Path: <linux-kernel-owner+w=401wt.eu-S932780AbXASAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbXASAIn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbXASAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:08:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4226 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932780AbXASAIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:08:43 -0500
Date: Fri, 19 Jan 2007 01:08:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.38-rc2
Message-ID: <20070119000848.GI9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.37:
- CVE-2006-4814: Fix incorrect user space access locking in mincore()
- CVE-2006-5173: i386: save/restore eflags in context switch
- CVE-2006-5749: Call init_timer() for ISDN PPP CCP reset state timer
- CVE-2006-5755: x86_64: Don't leak NT bit into next task
- CVE-2006-5757/CVE-2006-6060: grow_buffers() infinite loop fix
- CVE-2006-5823: corrupted cramfs filesystems cause kernel oops
- CVE-2006-6053: handle ext3 directory corruption better
- CVE-2006-6054: ext2: skip pages past number of blocks in ext2_find_entry
- CVE-2006-6056: hfs_fill_super returns success even if no root inode
- CVE-2006-6106: Bluetooth: Add packet size checks for CAPI messages


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git


Changes since 2.6.16.38-rc1:

Adrian Bunk (1):
      Linux 2.6.16.38-rc2

Paolo 'Blaisorblade' Giarrusso (1):
      UML: fix the MODE_TT compilation

YOSHIFUJI Hideaki (1):
      [IPV6] Fix joining all-node multicast group.


 Makefile                   |    2 +-
 arch/um/sys-i386/unmap.c   |   11 +++++++----
 arch/um/sys-x86_64/unmap.c |   11 +++++++----
 net/ipv6/addrconf.c        |    4 ++++
 net/ipv6/mcast.c           |    6 ------
 5 files changed, 19 insertions(+), 15 deletions(-)

