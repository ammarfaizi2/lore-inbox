Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCKQzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCKQzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCKQzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:55:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261214AbVCKQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:55:28 -0500
Date: Fri, 11 Mar 2005 17:55:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Message-ID: <20050311165526.GA3723@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de> <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 01:48:54PM -0500, Jeff Dike wrote:
> bunk@stusta.de said:
> > This patch is still wrong.
> > It seems my comment on this [1] was lost:
> > <--  snip  -->
> > This line has to be something like
> > ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> > && \
> >    HEAVILY_PATCHED_SUSE_GCC ) 
> 
> > I hope SuSE has added some #define to distinguish what they call  "gcc
> > 3.3.4" from GNU gcc 3.3.4 
> 
> It wasn't lost - I am just disinclined to cater to distros making their
> gcc lie about its version.

And therefore you added a patch that helps only those distros at the 
price of breaking other people and distros using sane compilers?

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

