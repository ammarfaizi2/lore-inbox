Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVAWJIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVAWJIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAWJIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:08:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17668 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261197AbVAWJII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:08:08 -0500
Date: Sun, 23 Jan 2005 10:08:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: can't compile 2.6.11-rc2 on sparc64
Message-ID: <20050123090806.GA3196@stusta.de>
References: <200501230238.55584@gj-laptop> <200501230248.27332@gj-laptop> <41F30848.6050408@osdl.org> <200501230909.17148@gj-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501230909.17148@gj-laptop>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 09:09:16AM +0100, Grzegorz Piotr Jaskiewicz wrote:
> On Sunday 23 January 2005 03:13, Randy.Dunlap wrote:
> 
> > It's the '-Werror' option that makes warnings become fatal
> > errors that is stopping you here.  You could edit
> > arch/sparc64/kernel/Makefile and remove/comment that for now.
> 
> Thanks, I didn't noticed that.
> Have built only x86_74 and i386 archs before, these don't use -Wall I guess. 
>...

All architectures use -Wall.

> GJ

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

