Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWHMIrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWHMIrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 04:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHMIrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 04:47:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750755AbWHMIrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 04:47:48 -0400
Subject: Re: [RFC] [PATCH 10/10] fs/jffs2/jffs2_fs_i.h Removal of old code
From: David Woodhouse <dwmw2@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44DE09CA.6020808@gmail.com>
References: <44DE05FC.2090001@gmail.com>  <44DE09CA.6020808@gmail.com>
Content-Type: text/plain
Date: Sun, 13 Aug 2006 09:47:42 +0100
Message-Id: <1155458863.4975.267.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 19:03 +0200, Michal Piotrowski wrote:
> Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
> 
> diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/fs/jffs2/jffs2_fs_i.h linux-work/fs/jffs2/jffs2_fs_i.h
> --- linux-work-clean/fs/jffs2/jffs2_fs_i.h	2006-08-12 01:51:17.000000000 +0200
> +++ linux-work/fs/jffs2/jffs2_fs_i.h	2006-08-12 17:53:04.000000000 +0200
> @@ -42,10 +42,8 @@ struct jffs2_inode_info {
>  	uint16_t flags;
>  	uint8_t usercompr;
>  #if !defined (__ECOS)
> -#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,2)
>  	struct inode vfs_inode;
>  #endif
> -#endif

Ack. I just got back from three weeks away; when I'm vaguely awake I'll
need to round up a bunch of patches to put into the git tree, and
this'll be one of them unless it's upstream already by then.

Thanks.

-- 
dwmw2

