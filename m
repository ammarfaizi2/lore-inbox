Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVKSUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKSUoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKSUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:44:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52741 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750817AbVKSUop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:44:45 -0500
Date: Sat, 19 Nov 2005 21:44:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: sam@ravnborg.org, akpm@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051119204444.GP16060@stusta.de>
References: <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org> <20051119003435.GA29775@mars.ravnborg.org> <20051118.171943.53979015.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118.171943.53979015.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 05:19:43PM -0800, David S. Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 19 Nov 2005 01:34:35 +0100
> 
> > On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> > > "David S. Miller" <davem@davemloft.net> wrote:
> > > >
> > > > The deprecated warnings are so easy to filter out, so I don't think
> > > >  noise is a good argument.  I see them all the time too.
> > > 
> > > That works for you and me.  But how to train all those people who write
> > > warny patches?
> > 
> > Would it work to use -Werror only on some parts of the kernel.
> > Thinking of teaching kbuild to recursively apply a flags to gcc.
> > 
> > Then we could say that kernel/ should be warning free (to a start).
> 
> Many ports already add -Werror to the CFLAGS via their
> arch/${ARCH}/* makefiles.

They only add it to EXTRA_CFLAGS for one specifig subdirectory.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

