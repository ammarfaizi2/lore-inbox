Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVGXQIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGXQIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 12:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVGXQIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 12:08:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261381AbVGXQIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 12:08:13 -0400
Date: Sun, 24 Jul 2005 18:08:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, netdev@vger.kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, jgarzik@pobox.com,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [05/11] SMP fix for 6pack driver
Message-ID: <20050724160805.GS3160@stusta.de>
References: <20050713184130.GA9330@kroah.com> <20050713184331.GG9330@kroah.com> <20050713220123.GA3292@electric-eye.fr.zoreil.com> <20050713221311.GA30039@kroah.com> <20050715193556.GB18059@stusta.de> <20050717210939.GA11884@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050717210939.GA11884@linux-mips.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 05:09:39PM -0400, Ralf Baechle wrote:
> On Fri, Jul 15, 2005 at 09:35:56PM +0200, Adrian Bunk wrote:
> 
> > I do agree with Francois regarding this issue:
> > 
> > AFAIR, there has been not one 2.6 kernel where this driver was available 
> > for SMP kernels.
> 
> Eh...  That after all is the raison d'etre for this patch :)
> 
> > It's therefore untested which problems might arise with 
> > this driver on SMP systems. I'm not arguing against including this 
> > driver in 2.6.13, but 2.6.12.3 isn't the right place.
> 
> Nonsense.  Most development activity for this stuff happens not on the
> internet and you won't be able to follow it unless you're a licensed ham.
> I've been circulating things patch since a while and nobody has been unhappy.

So why was it important to get it into 2.6.12.3?

I must have missed the announcement that the original -stable goals have 
been declared obsolete.

> > What surprises me most is that you accepted this patch is neither in 
> > 2.6.13-rc3 nor in 2.6.13-rc3-mm1. There seems to be either an
> > (IMHO unfortunate) change in your policy of what patches to accept,
> > or there's a serious problem in your patch review process.
> 
> I've sent it to jgarzik so it's somewhere on it's long way there.
> 
>   Ralf

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

