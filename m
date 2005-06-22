Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVFVQmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVFVQmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVFVQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:42:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62732 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261589AbVFVQmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:42:14 -0400
Date: Wed, 22 Jun 2005 18:42:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: George Kasica <georgek@netwrx1.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
Message-ID: <20050622164204.GH3705@stusta.de>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:28:25AM -0500, George Kasica wrote:
> Hello:
> 
> Trying to compile 2.6.12 here and am getting the following error. I am 
> currently running 2.4.31 and have upgraded the needed bits per the Change 
> document before trying the build:
> 
> [root@eagle src]# cd linux
> [root@eagle linux]# make mrproper
>   CLEAN   .config
> [root@eagle linux]# cp ../config-2.4.31 .config
> [root@eagle linux]# make oldconfig
>   HOSTCC  scripts/basic/fixdep
> In file included from /usr/local/include/netinet/in.h:212,
>...

What are these kernel headers under /usr/local ?
I don't see any reason why they should be there.

> George

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

