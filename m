Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753946AbWKVMMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbWKVMMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbWKVMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:12:14 -0500
Received: from rubidium.solidboot.com ([81.22.244.175]:35766 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1753946AbWKVMMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:12:13 -0500
Date: Wed, 22 Nov 2006 14:08:08 +0200
From: Imre =?iso-8859-1?Q?De=E1k?= <imre.deak@solidboot.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Imre Deak <imre.deak@solidboot.com>,
       Komal Shah <komal.shah802003@gmail.com>,
       James Simmons <jsimmons@infradead.org>, Vladimir <vovan888@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Siemens sx1: merge framebuffer support
Message-ID: <20061122120808.GA28102@mammoth.research.nokia.com>
References: <20061118181607.GA15275@elf.ucw.cz> <20061120190404.GD4597@atomide.com> <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com> <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org> <3a5b1be00611210734k79c81305q7b229139c2b17ef6@mail.gmail.com> <20061121164723.GB8193@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121164723.GB8193@atomide.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony and all,

On Tue, Nov 21, 2006 at 04:47:25PM +0000, Tony Lindgren wrote:
> Hi,
> 
> * Komal Shah <komal.shah802003@gmail.com> [061121 15:35]:
> > On 11/21/06, James Simmons <jsimmons@infradead.org> wrote:
> > >
> > >Can you post the framebufer driver to the framebuffer list. We like to do
> > >peer review. Thank you :-)
> 
> It would be nice to get the framebuffer integrated. I think it would be
> best if Imre submitted the patches as it's mostly his work.
> 
> Imre, do you have time to send the patches to framebuffer list? If not,
> I can send them.

Yes, I'm going to post it this week.

--Imre

> 
> > >On Tue, 21 Nov 2006, Vladimir wrote:
> > >
> > >> 2006/11/20, Tony Lindgren <tony@atomide.com>:
> > >> > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > >> > > From: Vladimir Ananiev <vovan888@gmail.com>
> > >> > >
> > >> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > >> > > one will be mixer/sound support). Support is simple / pretty minimal,
> > >> > > but seems to work okay (and is somehow important for a cell phone 
> > >:-).
> > >> >
> > >> > Pushed to linux-omap. I guess you're planning to send the missing
> > >> > Kconfig + Makefile patch for this?
> > >> >
> > >> > Also, it would be better to use omap_mcbsp_xmit_word() or
> > >> > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> > >> > it does not do any checking that it worked. The aic23 and tsc2101
> > >> > audio in linux-omap tree in general has the same problem.
> > >> >
> > >> > Regards,
> > >> >
> > >> > Tony
> > >> >
> > >>
> > >> Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> > >> so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> > >> -
> > 
> > Again, framebuffer support patch is based on the omap framebuffer
> > driver, which is not yet submitted to upstream/fbdevel list. sx1
> > framebuffer support just fill up the hooks required by -omap fb driver
> > framework.
> 
> Yes, but the framebuffer code is in pretty much ready to be sent
> upstream :)
> 
> Regards,
> 
> Tony
