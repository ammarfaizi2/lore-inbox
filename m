Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030709AbWK3QWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030709AbWK3QWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759256AbWK3QWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:22:01 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:1004 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1758520AbWK3QWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:22:00 -0500
Message-ID: <456F0549.2050801@cfl.rr.com>
Date: Thu, 30 Nov 2006 11:22:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
CC: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reiserfs add missing brackets
References: <200611301038.03140.m.kozlowski@tuxland.pl>
In-Reply-To: <200611301038.03140.m.kozlowski@tuxland.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2006 16:22:55.0403 (UTC) FILETIME=[CA8C57B0:01C7149B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14844.003
X-TM-AS-Result: No--6.552800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know it is just nit-picking, but those are parenthesis, not brackets.

() vs. []

Mariusz Kozlowski wrote:
> Hello,
> 
> 	This patch adds missing brackets. 
> 
>  include/linux/reiserfs_fs.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.19-rc6-mm2-a/include/linux/reiserfs_fs.h	2006-11-28 12:17:06.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/include/linux/reiserfs_fs.h	2006-11-30 01:05:38.000000000 +0100
> @@ -739,7 +739,7 @@ struct block_head {
>  #define PUT_B_FREE_SPACE(p_s_bh,val)  do { set_blkh_free_space(B_BLK_HEAD(p_s_bh),val); } while (0)
>  
>  /* Get right delimiting key. -- little endian */
> -#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))
> +#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))))
>  
>  /* Does the buffer contain a disk leaf. */
>  #define B_IS_ITEMS_LEVEL(p_s_bh)     (B_LEVEL(p_s_bh) == DISK_LEAF_NODE_LEVEL)
> 
> 

