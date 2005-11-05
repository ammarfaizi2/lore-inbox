Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVKERh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVKERh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVKERh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:37:27 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:5202 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1750893AbVKERh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:37:26 -0500
Message-ID: <436CEDCE.6010704@tremplin-utc.net>
Date: Sat, 05 Nov 2005 18:37:18 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: zippel@linux-m68k.org
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 66/82] remove linux/version.h from fs/hfs/
References: <20050710193614.66.sNRbVO4020.2247.olh@nectarine.suse.de>
In-Reply-To: <20050710193614.66.sNRbVO4020.2247.olh@nectarine.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2005 21:36, Olaf Hering wrote/a écrit:
> changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
Hello,

I've just changed LOCALVERSION on 2.6.14 and noticed that the patches 
for hfs and hfsplus had still not made their way. As I couldn't find any 
tree which contains them, I was wondering if they wouldn't have been 
"lost in space" ?

Eric

> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> fs/hfs/hfs_fs.h |    1 -
> fs/hfs/inode.c  |    1 -
> 2 files changed, 2 deletions(-)
> 
> Index: linux-2.6.13-rc2-mm1/fs/hfs/hfs_fs.h
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/fs/hfs/hfs_fs.h
> +++ linux-2.6.13-rc2-mm1/fs/hfs/hfs_fs.h
> @@ -9,7 +9,6 @@
> #ifndef _LINUX_HFS_FS_H
> #define _LINUX_HFS_FS_H
> 
> -#include <linux/version.h>
> #include <linux/slab.h>
> #include <linux/types.h>
> #include <linux/buffer_head.h>
> Index: linux-2.6.13-rc2-mm1/fs/hfs/inode.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/fs/hfs/inode.c
> +++ linux-2.6.13-rc2-mm1/fs/hfs/inode.c
> @@ -12,7 +12,6 @@
> */
> 
> #include <linux/pagemap.h>
> -#include <linux/version.h>
> #include <linux/mpage.h>
> 
> #include "hfs_fs.h"

