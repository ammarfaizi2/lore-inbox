Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265969AbSKBNcF>; Sat, 2 Nov 2002 08:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265970AbSKBNcF>; Sat, 2 Nov 2002 08:32:05 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:45070 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265969AbSKBNcD>; Sat, 2 Nov 2002 08:32:03 -0500
Date: Sat, 2 Nov 2002 14:38:24 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, lkml <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021102133824.GL28803@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15810.46998.714820.519167@crimson.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another one: trying to build 2.5.45 off a reiser4 mountpoint, I get:

reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[pdflush(7)]: flush_scan_extent (fs/reiser4/flush.c:3127)[nikita-2732]:
WARNING: Flush raced against extent->tail
reiser4[pdflush(7)]: jnode_flush (fs/reiser4/flush.c:1024)[jmacd-16739]:
WARNING: flush failed: -11
jnode_flush failed with err = -11
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 128
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 256
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 512
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 1024
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 2048
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 4096
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 8192
reiser4[fixdep(841)]: traverse_tree (fs/reiser4/search.c:465)[nikita-1481]:
WARNING: Too many iterations: 16384
reiser4[fixdep(952)]: extent2tail (fs/reiser4/plugin/file/tail_conversion.c:476)[nikita-2282]:
WARNING: Partial conversion of 105116: 1 of 2
reiser4[cc1(957)]: extent2tail (fs/reiser4/plugin/file/tail_conversion.c:476)[nikita-2282]:
WARNING: Partial conversion of 105116: 0 of 2
[snip]

... after which r4 crashes completely --
Starts to hog all cpu time and umount() never goes through.

T.
