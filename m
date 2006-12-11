Return-Path: <linux-kernel-owner+w=401wt.eu-S1762985AbWLKRax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762985AbWLKRax (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762989AbWLKRax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:30:53 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:29583 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1762985AbWLKRaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:30:52 -0500
Date: Mon, 11 Dec 2006 18:30:49 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Maria Short <mgolod@ieee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux slack space question
Message-ID: <20061211173049.GD29778@harddisk-recovery.com>
References: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 12:21:04PM -0500, Maria Short wrote:
> I have a question regarding how the Linux kernel handles slack space.
> I know that the ext3 filesystems typically use 1,2 or 4 KB blocks and
> if a file is not an even multiple of the block size then the last
> allocated block will not be completely filled, the remaining space is
> wasted as slack space.
> 
> What I need is the code in the kernel that does that. I have been
> looking at http://lxr.linux.no/source/fs/ext3/inode.c but I could not
> find the specific code for partially filling the last block and
> placing an EOF at the end, leaving the rest to slack space.

Think about it: what value would an EOF have if all byte values are
allowed in a file?

>From the very first Unix filesystem an inode contains both the number
of blocks it contains and the actual file size.

> Please forward the answer to mgolod@ieee.org as soon as possible.

Hmm no. You asked a public forum so the reply will go to that same
public forum. See http://catb.org/esr/faqs/smart-questions.html#noprivate .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
