Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268091AbUGWVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268091AbUGWVlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUGWVlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:41:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26367 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268091AbUGWVlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:41:04 -0400
Date: Fri, 23 Jul 2004 23:40:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A users thoughts on the new dev. model
Message-ID: <20040723214055.GR19329@fs.tum.de>
References: <40FFD760.8060504@unix.eng.ua.edu> <cdpee5$otu$1@gatekeeper.tmr.com> <cdr5i3$568$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdr5i3$568$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 01:58:27PM +0000, H. Peter Anvin wrote:
> Followup to:  <cdpee5$otu$1@gatekeeper.tmr.com>
> By author:    Bill Davidsen <davidsen@tmr.com>
> In newsgroup: linux.dev.kernel
> > 
> > I confess I feel that this new model is a return to the bad old days 
> > when the stable tree wasn't. Sounds as if Andrew is bored with the idea 
> > of letting 2.7 be the development tree and just being the gatekeeper of 
> > STABLE new features for 2.6. Perhaps 2.7 should be opened and Andrew 
> > will have a place to play, and features can drift to 2.6 more slowly.
> > 
> 
> I think the discussion we had at the kernel summit has been somewhat
> misrepresented by LWN et al.  What we discussed was really more of a
> "soft fork", with the -mm tree serving the purpose of 2.7, rather than
> a hard fork with a separate maintainer and putting ourselves in
> back/forward-porting hell all over again.
> 
> Note that Andrew's -mm tree *specificially* has infrastructure to keep
> changes apart and thus backporting to 2.6 mainstream of patches which
> have proven themselves becomes trivial.
>...

One problem from a user's point of view is that removal of obsolete code 
that works sufficiently for some users.

Andrew said explicitely in a mail to linux-kernel that he'd consider 
removing devfs "mid-2005" - and it didn't sound as if this would only be 
a -mm "feature".

Even if 2.7 is started this doesn't has to imply that it has to be 
flooded with big changes - a short 2.7 with relativley few invasive 
changes might also be an option.

> 	-hpa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

