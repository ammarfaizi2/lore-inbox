Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSF0Q46>; Thu, 27 Jun 2002 12:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSF0Q45>; Thu, 27 Jun 2002 12:56:57 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:10756 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP
	id <S316885AbSF0Q44>; Thu, 27 Jun 2002 12:56:56 -0400
Date: Thu, 27 Jun 2002 17:59:15 +0100
From: Alasdair Kergon <agk@uk.sistina.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] device-mapper for 2.4
Message-ID: <20020627175915.A28682@uk.sistina.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An up-to-date device-mapper patchset against 2.4.19-rc1
has gone up today at:
  http://people.sistina.com/~thornber/

Please send feedback if you can think of ways to improve it 
- or even to break it:-)

Device-mapper is a light-weight driver designed to support
volume managers generically.  It lets you define new block
devices composed of ranges of sectors of existing devices.
There are also patches to support snapshots and mirroring 
(LVM2 will use this to implement pvmove).

ftp://ftp.sistina.com/pub/LVM2/device-mapper/patches/
    linux-2.4.19-rc1-mempool.patch
    linux-2.4.19-rc1-mempool_slab.patch
    linux-2.4.19-rc1-vcalloc.patch
    linux-2.4.19-rc1-b_bdev_private.patch

    linux-2.4.19-rc1-config.patch
    linux-2.4.19-rc1-devmapper_1_core.patch
    linux-2.4.19-rc1-devmapper_2_ioctl.patch
    linux-2.4.19-rc1-devmapper_3_basic_mappings.patch

    linux-2.4.19-rc1-devmapper_4_snapshots.patch

    linux-2.4.19-rc1-devmapper_5_mirror.patch

Single patch combining the above:
    combined-linux-2.4.19-rc1-devmapper-ioctl.patch

Alasdair
--
agk@uk.sistina.com      UK Linux Developers' Conference 2002
                         July 4-7   Bristol   www.ukuug.org
