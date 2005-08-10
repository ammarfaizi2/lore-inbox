Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVHJHq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVHJHq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVHJHq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:46:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:32805 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965039AbVHJHq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:46:56 -0400
Date: Wed, 10 Aug 2005 08:48:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
In-Reply-To: <200508100923.55749.phillips@arcor.de>
Message-ID: <Pine.LNX.4.61.0508100843420.18223@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au> <200508090724.30962.phillips@arcor.de>
 <20050808145430.15394c3c.akpm@osdl.org> <200508100923.55749.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Aug 2005 07:46:56.0153 (UTC) FILETIME=[AE5AF090:01C59D7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Daniel Phillips wrote:
> --- 2.6.13-rc5-mm1.clean/include/linux/page-flags.h	2005-08-09 18:23:31.000000000 -0400
> +++ 2.6.13-rc5-mm1/include/linux/page-flags.h	2005-08-09 18:59:57.000000000 -0400
> @@ -61,7 +61,7 @@
>  #define PG_active		 6
>  #define PG_slab			 7	/* slab debug (Suparna wants this) */
>  
> -#define PG_checked		 8	/* kill me in 2.5.<early>. */
> +#define PG_miscfs		 8	/* kill me in 2.5.<early>. */
>  #define PG_fs_misc		 8

And all those PageMiscFS macros you're adding to the PageFsMisc ones:
doesn't look like progress to me ;)

Hugh
