Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbUBPPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUBPPnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:43:25 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:13301 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S265734AbUBPPnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:43:24 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: <1pSRf-31Z-5@gated-at.bofh.it>
References: <1nioI-5Re-1@gated-at.bofh.it> <1orqh-6gs-47@gated-at.bofh.it> <1ozGR-60N-1@gated-at.bofh.it> <1oAa3-6pR-37@gated-at.bofh.it> <1oBpi-7pO-1@gated-at.bofh.it> <1oCbM-8oW-9@gated-at.bofh.it> <1p9Kl-7BV-1@gated-at.bofh.it> <1piXj-1d3-3@gated-at.bofh.it> <1pRLy-21o-31@gated-at.bofh.it> <1pSRf-31Z-5@gated-at.bofh.it>
Date: Mon, 16 Feb 2004 16:44:48 +0100
Message-Id: <E1AskvQ-0000P0-1m@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 16:30:13 +0100, you wrote in linux.kernel:

> lurking corner cases too - what if you creat() a file, then do a
> readdir() and strcmp() each entry looking for your file (while
> comparing a filename smashed to UTF-8 to the original unsmashed string)?

That's broken on multitasking systems anyway. Even if you find the
same name, somebody (root process for example) might have unlinked your
file and created another with the same name between you calling creat()
and doing the readdir(). What would be the use of this, anyway?

-- 
Ciao,
Pascal
