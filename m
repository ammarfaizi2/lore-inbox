Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVEMSav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVEMSav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVEMSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:30:51 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:43171 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262473AbVEMSa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:30:29 -0400
Date: Fri, 13 May 2005 11:30:27 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
X-X-Sender: vlobanov@shell1.sea5.speakeasy.net
To: Andy Isaacson <adi@hexapodia.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Daniel Jacobowitz <dan@debian.org>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050513171300.GA30909@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0505131129060.6631@shell1.sea5.speakeasy.net>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
 <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net> <4284B55C.7010202@pobox.com>
 <20050513142336.GA6174@nevyn.them.org> <4284BA90.5080508@pobox.com>
 <20050513171300.GA30909@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Andy Isaacson wrote:

> On Fri, May 13, 2005 at 10:32:48AM -0400, Jeff Garzik wrote:
> > Daniel Jacobowitz wrote:
> > >  http://www.daemonology.net/hyperthreading-considered-harmful/
> >
> > Already read it.  This link provides no more information than either of
> > the above links provide.
>
> He's posted his paper now.
>
> http://www.daemonology.net/papers/htt.pdf
>
> It's a side channel timing attack on data-dependent computation through
> the L1 and L2 caches.  Nice work.  In-the-wild exploitation is
> difficult, though; your timing gets screwed up if you get scheduled away
> from your victim, and you don't even know, because you can't tell where
> you were scheduled, so on any reasonably busy multiuser system it's not
> clear that the attack is practical.
>
> -andy
> -

Wouldn't scheduling appear as a rather big time delta (in measuring the
cache access times), so you would know to disregard that data point?

(Just wondering... :-) )

-Vadim
