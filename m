Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTF1Af1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTF1Af1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:35:27 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:43181 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265054AbTF1AcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:32:09 -0400
From: Frank.Schmischke@t-online.de (frank.schmischke)
To: linux-kernel@vger.kernel.org
Subject: bug (?) in mounting disk
Date: Thu, 26 Jun 2003 02:42:40 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306260242.40215.frank.schmischke@t-online.de>
X-Seen: false
X-ID: V8LUY2ZBweVWebhPYHY2qgfyZo8TQ91elJbiKy9LitTruMpoZ51PEX@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have a big problem with kernel 2.4.21. I've installed 2.4.21 at 3 computers, 
where root-partition is on /dev/hda. There, the kernel is working fine.

But on my athlon 1000MHz, there I have a via-chipset for UDMA100. So I have a 
cdrom at /dev/hda and my disk is at /dev/hdc. Until kernel 2.4.20, everything 
works fine. But with kernel 2.4.21, the kernel will load module 
block-major-22, so that kernel will crash at fsck (no filesystem is mounted 
at this time). But ide-disk is compiled in kernel, not as a modul.
I have have also tried patch -ac2, but this will not help.

I'm using:
gcc-3.3
reiserfs-3.6.8
modutils-2.4.25
util-linux-2.11z
pciutils-2.1.11
binutils-2.14

Thanks
Frank

