Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGHWZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGHWZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 18:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUGHWZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 18:25:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29438 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263761AbUGHWZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 18:25:18 -0400
Date: Fri, 9 Jul 2004 00:25:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040708222511.GL28324@fs.tum.de>
References: <1089287198.3988.18.camel@nigel-laptop.wpcb.org.au> <20040708120719.GS21264@devserv.devel.redhat.com> <20040708205225.GI28324@fs.tum.de> <20040708210925.GA13908@devserv.devel.redhat.com> <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089324501.3098.9.camel@nigel-laptop.wpcb.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 08:08:21AM +1000, Nigel Cunningham wrote:

> Hi.

Hi Nigel,

> On Fri, 2004-07-09 at 07:09, Arjan van de Ven wrote:
> > the problem I've seen is that when gcc doesn't honor normal inline, it will
> > often error out if you always inline....
> > I'm open to removing the < 4 but as jakub said, 3.4 is quit good at honoring
> > normal inline, and when it doesn't there often is a strong reason.....
> 
> I'm busy for the next couple of days, but if you want, I'll make
> allyesconfig next week and go through fixing the compilation errors so
> that the < 4 can be removed. Rearranging code so that inline functions
> are defined before they're called or not declared inline if they can't
> always be inlined seems to me to be the right thing to do. (Feel free to
> say I'm wrong!).

I'm currently working on fixing the compile errors and I plan to send 
some fixes later.

> Regards,
> 
> Nigel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

