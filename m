Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVCCUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVCCUii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVCCUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:21:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262119AbVCCUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:20:42 -0500
Date: Thu, 3 Mar 2005 21:20:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: disallow modular framebuffers
Message-ID: <20050303202039.GH4608@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com> <20050303165649.GF4608@stusta.de> <200503040350.51163.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503040350.51163.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:50:42AM +0800, Antonino A. Daplas wrote:
>...
> > Is there any reason for these being three modules?
> > It seems the best solution would be to make this one module composed of
> > up to three object files?
> 
> Yes.

Two possible solutions:
- rename savagefb.c and link the three files into savagefb.o
- merge the other two files into savagefb.c

I'd slightly prefer the first choice, but I can send patches for 
whichever you prefer.

As a note, in both cases the EXPORT_SYMBOL's can be removed.

> Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

