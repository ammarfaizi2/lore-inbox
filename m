Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbTHUEpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 00:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbTHUEpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 00:45:35 -0400
Received: from air.nwconx.net ([216.211.26.26]:4556 "EHLO air.on.ca")
	by vger.kernel.org with ESMTP id S262408AbTHUEpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 00:45:16 -0400
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
To: linux-kernel@vger.kernel.org
Subject: Initramfs
Date: Thu, 21 Aug 2003 00:44:17 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308210044.17876.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to start off by thanking everybody for their help with my last 
question,  Much appreciated.

I am currently testing kernel 2.6.0-test3, specifically the initramfs feature, 
under VMWare

Upon booting I get the following:

Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8196 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
->(three characters, an 'o' with an I superimposed, a carat^, and a white 
smilyface)
Kernel panic: populate_root: bogus mode: 0

In idle task - not syncing

===Creation details - verbose===

I have created a directory tree on my system that I would like to use as a 
root fs.  I then created (from the root of that structure) the cpio archive 
by using
find | cpio -ov > ../filesystem.cpio
cd ..
gzip -9 filesystem.cpio
I then copied the file into the proper location in the source tree, compiled 
and had everything boot nicely.

I used syslinux to boot the kernel from a disk (only way I could get it to 
work on the virtual disk image to boot under VMWare)

===End of Creation details===

How would you suggest I go about fixing this problem, or do you require more 
information?  Also, is there a good detailed FAQ or a HOWTO document available 
online that I might be able to refer to?

Once again, thank you for your assistance.

Garrett Kajmowicz
gkajmowi@tbaytel.net

