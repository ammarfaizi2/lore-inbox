Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDIO1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDIO1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWDIO1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:27:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16133 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750739AbWDIO07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:26:59 -0400
Date: Sun, 9 Apr 2006 16:26:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Unaligned accesses in the ethernet bridge
Message-ID: <20060409142658.GB8454@stusta.de>
References: <17442.650.874609.271109@berry.ken.nicta.com.au> <20060406203708.GA7118@stusta.de> <20060407165711.1df5b52e@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407165711.1df5b52e@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 04:57:11PM -0700, Stephen Hemminger wrote:
> On Thu, 6 Apr 2006 22:37:08 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Thu, Mar 23, 2006 at 01:06:02PM +1100, Peter Chubb wrote:
> > > 
> > > I see lots of
> > > 	kernel unaligned access to 0xa0000001009dbb6f, ip=0xa000000100811591
> > > 	kernel unaligned access to 0xa0000001009dbb6b, ip=0xa0000001008115c1
> > > 	kernel unaligned access to 0xa0000001009dbb6d, ip=0xa0000001008115f1
> > > messages in my logs on IA64 when using the ethernet bridge with 2.6.16.
> > > 
> > > 
> > > Appended is a patch to fix them.
> > 
> > 
> > I see this patch already made it into 2.6.17-rc1.
> > 
> > It seems to be a candidate for 2.6.16.3, too?
> > If yes, please submit it to stable@kernel.org.
> 
> The code that caused this was new in 2.6.17

Ah sorry, Peter's "when using the ethernet bridge with 2.6.16" confused 
me.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

