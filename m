Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUDPULq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbUDPULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:11:40 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:30468 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263636AbUDPUJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:09:28 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: reiserfs-list@namesys.com
Subject: Re: [PATCH] reiserfs v3 fixes and features
Date: Fri, 16 Apr 2004 22:06:50 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
References: <1081274618.30828.30.camel@watt.suse.com> <1082141666.27614.1448.camel@watt.suse.com> <200404162147.16846@WOLK>
In-Reply-To: <200404162147.16846@WOLK>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200404162206.50654@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 21:47, Marc-Christian Petersen wrote:

Hi again,

> > ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5-mm6
> > Only reiserfs-group-alloc-9 has changed.

> hmm, does not apply to 2.6.5-mm6 (applied all from series.mm) before for
> sure.

Somewhen in the near future I'll forget my name ;(

This time with patch output:

root@codeman:[/usr/src/linux-2.6.5-mm6] # patch -p1 --dry-run < 
reiserfs-group-alloc-9.patch 
patching file fs/reiserfs/bitmap.c
Hunk #6 succeeded at 358 with fuzz 1.
Hunk #17 FAILED at 943.
1 out of 17 hunks FAILED -- saving rejects to file fs/reiserfs/bitmap.c.rej
patching file fs/reiserfs/file.c
Hunk #1 FAILED at 176.
Hunk #2 succeeded at 467 (offset -1 lines).
Hunk #3 succeeded at 1253 (offset -1 lines).
1 out of 3 hunks FAILED -- saving rejects to file fs/reiserfs/file.c.rej
patching file fs/reiserfs/inode.c
Hunk #1 succeeded at 1660 (offset 1 line).
Hunk #2 succeeded at 1729 (offset 1 line).
patching file fs/reiserfs/super.c
Hunk #2 succeeded at 650 (offset -4 lines).
Hunk #3 succeeded at 1345 (offset -21 lines).
patching file include/linux/reiserfs_fs.h
Hunk #2 succeeded at 2149 (offset 9 lines).

Freshly patched 2.6.5 vanilla with 2.6.5-mm6.

ciao, Marc
