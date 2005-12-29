Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVL2TG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVL2TG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVL2TG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:06:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28945 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750869AbVL2TG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:06:27 -0500
Date: Thu, 29 Dec 2005 20:06:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make vm86 support optional
Message-ID: <20051229190625.GN3811@stusta.de>
References: <20051228202735.GU3356@waste.org> <20051229043900.GD4872@stusta.de> <20051229184717.GY3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051229184717.GY3356@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 12:47:18PM -0600, Matt Mackall wrote:
> On Thu, Dec 29, 2005 at 05:39:00AM +0100, Adrian Bunk wrote:
> > On Wed, Dec 28, 2005 at 02:27:35PM -0600, Matt Mackall wrote:
> > >...
> > > +config VM86
> > > +	depends X86
> > > +	default y
> > > +	bool "Enable VM86 support" if EMBEDDED
> > > +	help
> > > +          This option is required by programs like DOSEMU to run 16-bit legacy
> > > +	  code on X86 processors. It also may be needed by software like
> > > +          XFree86 to initialize some video cards via BIOS. Disabling this
> > > +          option saves about 6k.
> > >...
> > 
> > I don't like such space statements ("about 6k") in help texts, since 
> > history has shown that noone updates them when the actual size 
> > changes...
> 
> What would you prefer? It's important to give a relative size vs
> functionality savings so people can decide whether they want a feature
> and simply saying a little/a lot is insufficient.

I'd expect people using the "enable only if you know what you are doing" 
EMBEDDED option to be able to figure out themselves how big a space 
saving is (and even more important whether they can actually live 
without the feature). 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

