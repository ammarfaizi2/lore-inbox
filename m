Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273007AbTG3PhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272994AbTG3PhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:37:01 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:25038 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S273406AbTG3Pf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:35:29 -0400
Date: Wed, 30 Jul 2003 08:35:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Message-ID: <20030730153527.GB27214@ip68-0-152-218.tc.ph.cox.net>
References: <200307232046.46990.bernie@develer.com> <200307242227.16439.bernie@develer.com> <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net> <200307300449.37692.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307300449.37692.bernie@develer.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:49:37AM +0200, Bernardo Innocenti wrote:
> On Wednesday 30 July 2003 00:29, Tom Rini wrote:
> 
> > > Some of the bigger 2.6 additions cannot be configured out.
> > > I wish sysfs and the different I/O schedulers could be removed.
> > >
> > > There are probably many other things mostly useless for embedded
> > > systems that I'm not aware of.
> >
> > Well, from Pat's talk at OLS, it seems like sysfs would be an important
> > part of 'sleep', which is something at least some embedded systems care
> > about.
> 
> I tried stripping sysfs away. I just saved 7KB and got a kernel that
> couldn't boot because root device translation depends on sysfs ;-)

Now that someone has gone down the path (and, thanks for doing it), we
know how much is saved and what needs to be done to get it to work.
Lets just hope it doesn't grow that much more.

> > ... not that 2.6 doesn't need some good pruning options now, but maybe
> > CONFIG_EMBEDDED isn't the right place to put them all.
> 
> In the long term the embedded menu would get cluttered with all kinds
> of disparate options... I don't think I would like it.

Certainly.  I hope to have more time to get the tweaks patch I talked
about in one of the CONFIG_TINY threads a bit further along (1
dependancy left to get right) and at least get some discussion going on
it, but not now.

-- 
Tom Rini
http://gate.crashing.org/~trini/
