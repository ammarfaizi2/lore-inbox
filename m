Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSEDOxy>; Sat, 4 May 2002 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSEDOxx>; Sat, 4 May 2002 10:53:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18450 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313702AbSEDOxv>; Sat, 4 May 2002 10:53:51 -0400
Date: Sat, 4 May 2002 16:54:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: 2.4.19pre8aa2
Message-ID: <20020504165440.C1260@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This basically fixes a few compile problems (most of them noticed by
Eyal incidentally in CC) with some driver that I don't use myself and it
cleanups some other bit like with vmalloc_to_page. Nothing important
here if aa1 just compiled for you.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa2/

Diff between 19pre8aa1 and 19pre8aa2:

Only in 2.4.19pre8aa2: 00_8253-1
Only in 2.4.19pre8aa1: 00_VM_IO-3
Only in 2.4.19pre8aa2: 00_VM_IO-4

	Compilation fixes from Eyal Lebedinsky.

Only in 2.4.19pre8aa2: 00_compile-nfsroot-1

	Fix nfsroot compilation from Hubert Mantel.

Only in 2.4.19pre8aa2: 00_comx-driver-compile-1

	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
	it can link as a module, noticed by Eyal Lebedinsky.

Only in 2.4.19pre8aa2: 10_pte-highmem-f00f-2
Only in 2.4.19pre8aa1: 21_pte-highmem-f00f-1

	Cleanup, patch f00f fixmap before pte-highmem (pte-highmem
	depends on it so it make sense to apply it first).

Only in 2.4.19pre8aa1: 20_kiobuf-slab-2
Only in 2.4.19pre8aa2: 20_kiobuf-slab-3

	Fix compilation with blkmtd.c driver, noticed by Eyal Lebedinsky.

Only in 2.4.19pre8aa1: 20_pte-highmem-23
Only in 2.4.19pre8aa2: 20_pte-highmem-24

	Make use of vmalloc_to_page, merged from the diff between 2.4.19pre7ac2
	and 2.4.19pre7ac3. Also fixes the ieee1394/dv1394.o driver noticed by
	Eyal Lebedinsky.

Only in 2.4.19pre8aa1: 50_uml-patch-2.4.18-21.gz
Only in 2.4.19pre8aa2: 50_uml-patch-2.4.18-22.gz
Only in 2.4.19pre8aa2: 59_uml-yield-1

	Merged latest uml updates from Jeff at user-mode-linux.sourceforge.net,
	this is the fixed one that can boot uml inside uml.

Andrea
