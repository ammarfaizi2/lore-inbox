Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbUKDAE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUKDAE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUKCXoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:44:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:42630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261996AbUKCXkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:40:17 -0500
Date: Wed, 3 Nov 2004 15:44:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: jgarzik@mandrakesoft.com, orinoco-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Cosmetic updates for orinoco driver
Message-Id: <20041103154407.4d9833ca.akpm@osdl.org>
In-Reply-To: <20041103022444.GA14267@zax>
References: <20041103022444.GA14267@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> This patch reformats printk()s and some other cosmetic strings in the
> orinoco driver.  Also moves, removes, and adds ratelimiting in some
> places.  Behavioural changes are trivial/cosmetic only.  This reduces
> the cosmetic/trivial differences between the current kernel version,
> and the CVS version of the driver; one small step towards full merge.

This produces a ghastly reject storm against Jeff's bk-netdev tree.

I dunno how Jeff wants to handle that.  I stuck a copy of his current patch
(against 2.6.10-rc1) at
http://www.zip.com.au/~akpm/linux/patches/stuff/bk-netdev.patch and shall
now run away.

