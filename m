Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272449AbTGZKf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272451AbTGZKf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:35:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39407 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272449AbTGZKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:35:22 -0400
Date: Sat, 26 Jul 2003 12:50:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Harald Welte <laforge@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup
Message-ID: <20030726105021.GH22218@fs.tum.de>
References: <20030717201304.GL1407@fs.tum.de> <20030718012910.0D5BB2C5A9@lists.samba.org> <20030725205024.GA3244@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725205024.GA3244@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:50:24PM +0200, Harald Welte wrote:
> On Fri, Jul 18, 2003 at 11:06:49AM +1000, Rusty Russell wrote:
> > In message <20030717201304.GL1407@fs.tum.de> you write:
> >
> > > the patch below does the following changes to the netfilter entries in
> > > Configure.help in 2.4.22-pre2:
> > > - order similar to net/ipv4/netfilter/Config.in
> > > - remove useless short descriptions above CONFIG_*
> > > - added CONFIG_IP_NF_MATCH_RECENT entry (stolen from 2.5)
> > 
> > Sorry Adrian, I think this is overzealous.
> > 
> > Please just add the CONFIG_IP_NF_MATCH_RECENT entry.  Remember,
> > "stable" means "boring". 8)
> 
> I will submit the RECENT entry to davem with my next set of patches.
> 
> Does everybody else have an ordered Configure.help?  if yes, I'd accept

Most subsytems have their Configure.help entries ordered according to 
the Config.in order.

> the patch to comply with common practice.  If not, I would just say: who
> cares about the order, it's processed by {old,menu,x}config anyway.

I'm not religious regarding the order of Configure.help entries, and in 
2.6 this problem will be non-existant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

