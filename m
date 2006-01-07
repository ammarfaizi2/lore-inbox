Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWAGQUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWAGQUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbWAGQUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 11:20:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030477AbWAGQUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 11:20:32 -0500
Date: Sat, 7 Jan 2006 17:20:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm2: why is __get_page_state() global again?
Message-ID: <20060107162030.GK3774@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 05:22:21AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm1:
>...
> +revert-mm-page_state-fixes.patch
> 
>  This was a deoptimisation
>...

>From reading the patch description I don't understand why this makes 
__get_page_state() global again.

Is there a reason or is this accidentally?
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

