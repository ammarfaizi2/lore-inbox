Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVD3Xjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVD3Xjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVD3Xjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 19:39:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55312 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261459AbVD3Xjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 19:39:37 -0400
Date: Sun, 1 May 2005 01:39:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/tty_io.c: make a function static
Message-ID: <20050430233934.GX3571@stusta.de>
References: <20050430200827.GT3571@stusta.de> <20050430145907.2a6b9c95.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430145907.2a6b9c95.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 02:59:07PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This patch makes a needlessly global function static.
> > 
> > ...
> >  -extern int tty_paranoia_check(struct tty_struct *tty, struct inode *inode,
> >  -			      const char *routine);
> 
> Is used in fs/compat_ioct.c.

Sorry.

I missed this while grepping and it didn't show up in my i386 test 
compiles.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

