Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUCWRUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCWRUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:20:12 -0500
Received: from math.ut.ee ([193.40.5.125]:27319 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262713AbUCWRUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:20:07 -0500
Date: Tue, 23 Mar 2004 19:20:05 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.26-pre5: XFS module link errors on PPC
Message-ID: <Pine.GSO.4.44.0403231854160.14177-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to make enamble a modular XFS on my PPC using current linux-2.4
bitkeeper snaphot. Unfortunately, there are unresolved symbols in xfs
module:

depmod: *** Unresolved symbols in /lib/modules/2.4.26-pre5/kernel/fs/xfs/xfs.o
depmod:         ioremap_bot
depmod:         vmalloc_start

XFS works fine when compiled in statically.

-- 
Meelis Roos (mroos@linux.ee)


