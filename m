Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268181AbTAKWHk>; Sat, 11 Jan 2003 17:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268182AbTAKWHk>; Sat, 11 Jan 2003 17:07:40 -0500
Received: from h-64-105-35-9.SNVACAID.covad.net ([64.105.35.9]:62641 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268181AbTAKWHj>; Sat, 11 Jan 2003 17:07:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 11 Jan 2003 14:16:13 -0800
Message-Id: <200301112216.OAA16593@baldur.yggdrasil.com>
To: hch@lst.de, torvalds@transmeta.com
Subject: Re: [PATCH] umode_t changes from Adam's mini-devfs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>The use of umode_t instead of devfs-specific char vs block #defines
>in Adam's mini-devfs patch makes sense independant of whether his patch
>should get merged.  While reviewing his changes I also notices that
>most of the number allocation functionality in devfs has no business
>beeing exported.  In addition I cleaned up devfs_alloc_devnum/
>devfs_dealloc_devnum a bit.

	It looks good to me, although I haven't tried it or fully
comprehended every line of Christoph's devfs_{,de}alloc_devnum cleanup
(I have looked at it a bit before sending this email though).

	One really minor suggestion: perhaps Christoph could add an
entry in the giant change log in fs/devfs/util.c so that people know
who to contact if there is a problem with his number allocation
change.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
