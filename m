Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVCVTVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVCVTVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVCVTVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:21:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33802 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261693AbVCVTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:21:24 -0500
Date: Tue, 22 Mar 2005 20:21:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322192122.GG1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de> <42405AD6.9010804@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42405AD6.9010804@namesys.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 09:50:14AM -0800, Hans Reiser wrote:

> All of my technical arguments on this topic were nicely obliterated by
> Andrew.  The only real reason remaining (that I know of) is that I want
> to first eliminate all things which are a barrier to inclusion before
> dealing with this because it requires man hours to fix it.  If you want
> to send us a cleanup patch that fixes it, I would be grateful for your
> time donatioin.

My plan is to send a patch to Andrew that unconditionally enables 
4KSTACKS for shaking out the last bugs before possibly removing
8 kB stacks completely.

I don't know whether this is barrier to inclusion, but this will make 
reiser4 unavailable on i386...

> Hans

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

