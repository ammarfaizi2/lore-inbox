Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUJXQMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUJXQMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUJXQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:05:55 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:44306 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261565AbUJXQFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:05:35 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] merge msdos_fs_{i,sb}.h into msdos_fs.h
References: <20041024134812.GA20353@lst.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 25 Oct 2004 01:04:38 +0900
In-Reply-To: <20041024134812.GA20353@lst.de> (Christoph Hellwig's message of
 "Sun, 24 Oct 2004 15:48:12 +0200")
Message-ID: <87acuc2jc9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> --- 1.42/include/linux/msdos_fs.h	2004-10-20 10:12:10 +02:00
> +++ edited/include/linux/msdos_fs.h	2004-10-20 22:06:30 +02:00
> @@ -189,8 +189,84 @@
>  #include <linux/buffer_head.h>
>  #include <linux/string.h>
>  #include <linux/nls.h>
> -#include <linux/msdos_fs_i.h>
> -#include <linux/msdos_fs_sb.h>
> +#include <linux/fs.h>
> +
> +struct fat_mount_options {
> +	uid_t fs_uid;
> +	gid_t fs_gid;

Thanks. I'll submit after start 2.6.10.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
