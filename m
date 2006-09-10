Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWIJW4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWIJW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWIJW4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:56:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61964 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964793AbWIJW4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:56:23 -0400
Date: Mon, 11 Sep 2006 00:56:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.29-rc2
Message-ID: <20060910225622.GB4672@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still several patches pending - they will go into 2.6.16.30.

Security fixes since 2.6.16.28:
- CVE-2006-3468: NFS over ext3 DoS
- NFS over ext2 DoS
- ipv6: oops triggerable by any user


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.29-rc1:

Adrian Bunk:
      Linux 2.6.16.29-rc2

Neil Brown:
      Have ext2 reject file handles with bad inode numbers early.


 Makefile        |    2 +-
 fs/ext2/super.c |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

