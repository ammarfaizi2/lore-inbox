Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVKKCNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVKKCNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKKCNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 21:13:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751236AbVKKCM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 21:12:59 -0500
Date: Fri, 11 Nov 2005 03:12:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20051111021258.GK5376@stusta.de>
References: <20051107200336.GH3847@stusta.de> <20051110042857.38b4635b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110042857.38b4635b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 04:28:57AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Currently, using an undeclared function gives a compile warning, but it 
> >  can lead to a nasty runtime error if the prototype of the function is 
> >  different from what gcc guessed.
> > 
> >  With -Werror-implicit-function-declaration, we are getting an immediate 
> >  compile error instead.
> > 
> >  There will be some compile errors in cases where compilation previously
> >  worked because the undefined function wasn't called due to gcc dead code
> >  elimination, but in these cases a proper fix doesnt harm.
> > 
> 
> Sorry, I need to build allmodconfig kernels on wacky architectures (eg
> ppc64) and this patch is killing me.

Can you send me the list of compile errors so that I can work on fixing 
them?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

