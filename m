Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbTH0Hiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTH0Hiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:38:54 -0400
Received: from angband.namesys.com ([212.16.7.85]:10120 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263044AbTH0Hix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:38:53 -0400
Date: Wed, 27 Aug 2003 11:38:49 +0400
From: Oleg Drokin <green@namesys.com>
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030827073849.GA29071@namesys.com>
References: <20030826102233.GA14647@namesys.com> <20030826232844.25e0e9b3.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826232844.25e0e9b3.aradorlinux@yahoo.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 11:28:44PM +0200, Diego Calleja Garc?a wrote:

> btw, I suppose this feature will be removed if/when reiser4 is merged?:
> config REISER4_FS_SYSCALL
>         bool "Enable reiser4 system call"

No. It will be fixed.

> dmesg errors:
> (fs/ext3/inode.c, 2728): ext3_write_inode: called recursively, non-PF_MEMALLOC!
> Call Trace:
>  [<c018c715>] write_inode+0x45/0x50
>  [<c018c9af>] __sync_single_inode+0x28f/0x310
>  [<c018cd00>] generic_sync_sb_inodes+0x1c0/0x2e0

Hm. Interesting Thank you for the report. We will fix it.

Bye,
    Oleg
