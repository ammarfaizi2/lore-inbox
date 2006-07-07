Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWGGHSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWGGHSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWGGHSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:18:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26889 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751265AbWGGHSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:18:09 -0400
Date: Fri, 7 Jul 2006 09:18:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20060707071808.GZ26941@stusta.de>
References: <20060706163728.GN26941@stusta.de> <20060707033630.GA15967@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707033630.GA15967@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 05:36:30AM +0200, Sam Ravnborg wrote:
> On Thu, Jul 06, 2006 at 06:37:28PM +0200, Adrian Bunk wrote:
> > Currently, using an undeclared function gives a compile warning, but it 
> > can lead to a nasty to debug runtime stack corruptions if the prototype 
> > of the function is different from what gcc guessed.
> > 
> > With -Werror-implicit-function-declaration we are getting an immediate
> > compile error instead.
> This patch broke (-rc1):
> 
> sparc allnoconfig build
> ia64 allnoconfig build
> ppc64 allnoconfig build
>...

I did defconfig builds on 12 architectures, but no allnoconfig builds.

I'll try to fix them.

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

