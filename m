Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVHJXmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVHJXmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVHJXmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:42:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932609AbVHJXmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:42:52 -0400
Date: Thu, 11 Aug 2005 01:42:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
Message-ID: <20050810234246.GT4006@stusta.de>
References: <42F57FCA.9040805@yahoo.com.au> <20050808145430.15394c3c.akpm@osdl.org> <200508110812.59986.phillips@arcor.de> <200508110823.53593.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110823.53593.phillips@arcor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 08:23:53AM +1000, Daniel Phillips wrote:
> Note: I have not fully audited the NFS-related colliding use of page flags bit 
> 8, to verify that it really does not escape into VFS or MM from NFS, in fact 
> I have misgivings about end_page_fs_misc which uses this flag but has no 
> in-tree users to show how it is used and, hmm, isn't even _GPL.  What is up?
> 
> And note the wrongness tacked onto the end of page-flags.h.  I didn't do it!

This is provide-a-filesystem-specific-syncable-page-bit.patch, and it's 
only in -mm.

Since this was done only for CacheFS, and Andrew dropped CacheFS from 
-mm he could drop this patch as well.

> Regards,
> 
> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

