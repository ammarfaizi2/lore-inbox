Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVI1Q23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVI1Q23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVI1Q23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:28:29 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:49872 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751341AbVI1Q22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:28:28 -0400
Date: Thu, 29 Sep 2005 01:27:05 +0900 (JST)
Message-Id: <20050929.012705.37532453.anemo@mba.ocn.ne.jp>
To: stern@rowland.harvard.edu
Cc: jim.ramsay@gmail.com, mdharm-kernel@one-eyed-alien.net,
       ralf@linux-mips.org, linux-usb-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.44L0.0509271120370.5703-100000@iolanthe.rowland.org>
References: <20050927.234616.36922370.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.44L0.0509271120370.5703-100000@iolanthe.rowland.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 27 Sep 2005 11:38:35 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> said:

stern> If that is so, it's a bug in linux-mips.  ARCH_KMALLOC_MINALIGN
stern> is supposed to be at least as large as a cacheline.  See this
stern> comment in mm/slab.c:

Thank you for pointing out this.

Some time ago I also supposed so, but I was told to use
dma_get_cache_alignment() instead.  The comment was not exist at that
time...

OK, I will talk to MIPS maintainar again.
---
Atsushi Nemoto
