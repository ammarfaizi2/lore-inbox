Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSEVMwG>; Wed, 22 May 2002 08:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSEVMwF>; Wed, 22 May 2002 08:52:05 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:52802 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S313157AbSEVMwE>; Wed, 22 May 2002 08:52:04 -0400
Date: Wed, 22 May 2002 13:51:28 +0100
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com, lvm-devel@sistina.com
Subject: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020522125128.GA2009@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beta3 of device-mapper is now available at:

   ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-beta3.0.tgz

The accompanying LVM2 toolset:

   ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-beta3.0.tgz

The main addition for this release is high performance persistent
snapshots, see http://people.sistina.com/~thornber/snap_performance.html
for a comparison with LVM1 and EVMS.

Please be warned that snapshots will deadlock under load on 2.4.18
kernels due to a bug in the VM syste, 2.4.19-pre8 works fine.

pvmove is now the only major feature that LVM2 lacks compared with
LVM1.

- The LVM2 team (Patrick Caulfield, Alasdair Kergon, Joe Thornber)
