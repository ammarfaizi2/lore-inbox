Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVFVViv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVFVViv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVFVVdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:33:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262533AbVFVVal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:30:41 -0400
Date: Wed, 22 Jun 2005 23:30:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, George Kasica <georgek@netwrx1.com>
Subject: Re: Problem compiling 2.6.12
Message-ID: <20050622213038.GA3749@stusta.de>
References: <200506222037.17738.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506222037.17738.nick@linicks.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 08:37:17PM +0100, Nick Warne wrote:
> George Kasica wrote:
> 
> > Tried that here and got not much farther...here's the error:
> > 
> > [root@eagle linux]# make bzImage
> >    CHK     include/linux/version.h
> >    SPLIT   include/linux/autoconf.h -> include/config/*
> >    HOSTCC  scripts/mod/sumversion.o
> > In file included from /usr/include/linux/errno.h:4,
> 
> That last line looks wrong...  I think you may have symlinks linking to other 
> older kernel header stuff.
>...

No, it looks correct.

That's the copy of linux/errno.h shipped with glibc and that's correct 
when using HOSTCC.

The problem seems to be the /usr/local/ stuff.

> Nick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

