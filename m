Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVCAUQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVCAUQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCAUQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:16:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9224 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262014AbVCAUQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:16:32 -0500
Date: Tue, 1 Mar 2005 21:16:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-ID: <20050301201631.GF4845@stusta.de>
References: <20050301012741.1d791cd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:27:41AM -0800, Andrew Morton wrote:
>...
> All 728 patches:
>...
> reiser4-rcu-barrier.patch
>   reiser4: add rcu_barrier() synchronization point

Considering the patent situation at least in the USA, the 
EXPORT_SYMBOL(rcu_barrier) has to become an EXPORT_SYMBOL_GPL.

> reiser4-export-inode_lock.patch
>   reiser4: export inode_lock to modules
>...

__iget seems to be no longer used by reiser4.
This part of the patch can therefore be dropped.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

