Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWAaDqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWAaDqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWAaDqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:46:19 -0500
Received: from xenotime.net ([66.160.160.81]:35294 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030315AbWAaDqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:46:18 -0500
Date: Mon, 30 Jan 2006 19:46:41 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: Fix "make mandocs" for fs/inode.c
Message-Id: <20060130194641.76401872.rdunlap@xenotime.net>
In-Reply-To: <20060131034634.GT1501@kurtwerks.com>
References: <20060131034634.GT1501@kurtwerks.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 22:46:34 -0500 Kurt Wall wrote:

> "make mandocs" complains on fs/inode.c because touch_atime() has an undescribed paramter. This patch silences the complaint by describing the param. Also update the kernel-doc entry to reflect dentry usage over raw inode access.
> 
> Signed-off-by: Kurt Wall <kwall@kurtwerks.com>
> 
> 
> --- ./linux-2.6.16-rc1/fs/inode.c.orig	2006-01-21 09:30:59.000000000 -0500
> +++ ./linux-2.6.16-rc1/fs/inode.c	2006-01-30 22:45:38.000000000 -0500
> @@ -1179,7 +1179,7 @@
>  /**
>   *	touch_atime	-	update the access time
>   *	@mnt: mount the inode is accessed on
> - *	@inode: inode accessed
> + *	@dentry: dentry containing the inode to update

patched on 2006-JAN-21 by Martin Waitz.

Most of the others have also been submitted, either on
linux-kernel or linux-ide (for ATA) mailing lists.  Sorry.
Thanks for trying to help out, though.

---
~Randy
