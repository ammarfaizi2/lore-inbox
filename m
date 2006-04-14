Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWDNQ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWDNQ7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWDNQ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:59:23 -0400
Received: from mail.parknet.jp ([210.171.160.80]:56325 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751288AbWDNQ7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:59:22 -0400
X-AuthUser: hirofumi@parknet.jp
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC: 2.6 patch] fs/fat/misc.c: unexport fat_sync_bhs
References: <20060414114236.GK4162@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 15 Apr 2006 01:59:12 +0900
In-Reply-To: <20060414114236.GK4162@stusta.de> (Adrian Bunk's message of "Fri, 14 Apr 2006 13:42:36 +0200")
Message-ID: <87r740jdpb.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch removes the unused EXPORT_SYMBOL_GPL(fat_sync_bhs).
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.17-rc1-mm2-full/fs/fat/misc.c.old	2006-04-14 12:49:47.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/fs/fat/misc.c	2006-04-14 12:50:19.000000000 +0200
> @@ -210,4 +210,3 @@
>  	return err;
>  }
>  
> -EXPORT_SYMBOL_GPL(fat_sync_bhs);

Good, thanks. Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
