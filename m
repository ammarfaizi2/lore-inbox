Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314498AbSDRXgj>; Thu, 18 Apr 2002 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSDRXgi>; Thu, 18 Apr 2002 19:36:38 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:36269 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S314498AbSDRXgi>;
	Thu, 18 Apr 2002 19:36:38 -0400
Date: Fri, 19 Apr 2002 01:36:36 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204182336.BAA22417@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: disk throughput down in 2.5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it just me or is disk I/O throughput way down in 2.5.8?

I was preparing to build 2.4.19-pre7 on a box running 2.5.8,
when I noticed that 'tar zxvf' on the kernel tarball seemed
slow and jerky. So I ran

	cd /tmp; time tar zxf /path/to/linux-2.5.8.tar.gz

on several boxes(*), comparing 2.4.19-pre7 with 2.5.8.

On the older boxes (2 PentiumIIs and one K6-III), 2.5.8 was slower
by factors of 2.3-4.5. A P4 with an IBM 60GXP "only" suffered a
40% slowdown.

/Mikael

(*) Standard Intel chipset PCs, IDE disks, ext2 file systems,
newly booted, idle, etc.
