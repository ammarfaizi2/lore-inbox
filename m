Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVGAX3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGAX3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVGAX3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:29:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261626AbVGAX3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:29:01 -0400
Date: Sat, 2 Jul 2005 01:28:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] inotify: fsnotify.h: use kstrdup
Message-ID: <20050701232859.GD3592@stusta.de>
References: <20050701225559.GC3592@stusta.de> <52ekai15bi.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ekai15bi.fsf@topspin.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 04:20:49PM -0700, Roland Dreier wrote:

> Why not just convert all calls of fsnotify_oldname_init() to kstrdup()
> and delete the inline function?  The wrapper isn't adding much beyond
> hard-coding GFP_KERNEL.

There's a different wrapper for CONFIG_INOTIFY=n.

>  - R.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

