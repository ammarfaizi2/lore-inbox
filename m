Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJQFEN>; Thu, 17 Oct 2002 01:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbSJQFEN>; Thu, 17 Oct 2002 01:04:13 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:41397 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261799AbSJQFEM>; Thu, 17 Oct 2002 01:04:12 -0400
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.18139.620830.185192@sofia.bsd2.kbnes.nec.co.jp>
Date: Thu, 17 Oct 2002 14:12:59 +0900
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Trivial ext2-as-a-module fix vs 2.5.43
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell (rusty@rustcorp.com.au) writes:

> Needs these two symbols exported, as I think, does ext3. 

They're needed for NFS as a module too.  Please apply the patch.

depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.43-root/lib/modules/2.5.43-1sb/kernel/fs/nfs/nfs.o
depmod:         generic_file_aio_read
depmod:         generic_file_aio_write

