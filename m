Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVFVVnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVFVVnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVFVVj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:39:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60432 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262390AbVFVVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:33:57 -0400
Date: Wed, 22 Jun 2005 23:33:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: George Kasica <georgek@netwrx1.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
Message-ID: <20050622213352.GB3749@stusta.de>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com> <20050622164204.GH3705@stusta.de> <Pine.LNX.4.62.0506221415460.25918@eagle.netwrx1.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506221415460.25918@eagle.netwrx1.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 02:22:10PM -0500, George Kasica wrote:

> I have no idea what you are referring to there. If you can give me details 
> on what information you need or what you need me to do here I'll try to 
> provide it. I'm unfortunately not a kernel hacker or programmer here.

Where does /usr/local/include/ come from, what is it linked to,... ???

/usr/include contains a copy of kernel headers shipped by your glibc.

/path/to/your/kernel/sources/include contains a copy of kernel headers 
shipped with the kernel you are trying to compile.

But where do these kernel headers under /usr/local/include/ come from?

> George
> 
> >On Wed, Jun 22, 2005 at 10:28:25AM -0500, George Kasica wrote:
> >>Hello:
> >>
> >>Trying to compile 2.6.12 here and am getting the following error. I am
> >>currently running 2.4.31 and have upgraded the needed bits per the Change
> >>document before trying the build:
> >>
> >>[root@eagle src]# cd linux
> >>[root@eagle linux]# make mrproper
> >>  CLEAN   .config
> >>[root@eagle linux]# cp ../config-2.4.31 .config
> >>[root@eagle linux]# make oldconfig
> >>  HOSTCC  scripts/basic/fixdep
> >>In file included from /usr/local/include/netinet/in.h:212,
> >>...
> >
> >What are these kernel headers under /usr/local ?
> >I don't see any reason why they should be there.
> >
> >>George
> >
> >cu
> >Adrian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

