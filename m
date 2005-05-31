Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVEaQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEaQqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVEaQSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:18:55 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:63666 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261935AbVEaQJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:09:50 -0400
Date: Tue, 31 May 2005 09:09:46 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixes the warnings obtained with arm-elf-gcc 3.4
Message-Id: <20050531090946.6435242c.rdunlap@xenotime.net>
In-Reply-To: <81083a45050531035260ce77b0@mail.gmail.com>
References: <81083a450505310337131c3e31@mail.gmail.com>
	<81083a4505053103506aba48d5@mail.gmail.com>
	<81083a45050531035260ce77b0@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 16:22:40 +0530 Ashutosh Naik wrote:

| Sorry for the repeating mails
| 
| This patch fixes the warnings obtained with arm-elf-gcc 3.4.
| 
| Files Affected -
| 
| -fs/jffs2/read.c
| -fs/jffs2/nodemgmt.c
| -fs/jffs2/readinode.c
| -fs/jffs2/write.c
| -fs/jffs2/gc.c
| -fs/jffs2/erase.c
| -fs/nfs/nfs2xdr.c
| -fs/nfs/nfs3xdr.c
| -drivers/base/dmapool.c
| -drivers/char/random.c
| -drivers/serial/8250_early.c
| -net/core/dev.c
| -net/sunrpc/xprt.c
| -net/sunrpc/svc.c
| -net/sunrpv/svcsock.c
| 
| Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

These patches seem to be against plain 2.6.11, is that right?

Hint:  They don't apply cleanly to 2.6.12-rc5.  You should send
patches that apply cleanly to the latest mainline kernel version,
which is currently 2.6.12-rc5, or even better, patches to
2.6.12-rc5-git5 (or linux-git-current).


Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file drivers/base/dmapool.c.rej
2 out of 2 hunks FAILED -- saving rejects to file drivers/char/random.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file drivers/serial/8250_early.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
3 out of 3 hunks ignored -- saving rejects to file fs/jffs2/gc.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
2 out of 2 hunks ignored -- saving rejects to file fs/jffs2/nodemgmt.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file fs/jffs2/read.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file fs/jffs2/readinode.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file fs/jffs2/write.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
2 out of 2 hunks ignored -- saving rejects to file fs/nfs/nfs2xdr.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
3 out of 3 hunks ignored -- saving rejects to file fs/nfs/nfs3xdr.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
2 out of 2 hunks ignored -- saving rejects to file net/core/dev.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file net/sunrpc/svc.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
2 out of 2 hunks ignored -- saving rejects to file net/sunrpc/svcsock.c.rej
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
1 out of 1 hunk ignored -- saving rejects to file net/sunrpc/xprt.c.rej


---
~Randy
