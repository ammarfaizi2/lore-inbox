Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVGZJBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVGZJBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGZJBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 05:01:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:29890 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261648AbVGZJBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 05:01:44 -0400
Date: Tue, 26 Jul 2005 13:01:14 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Harald Welte <laforge@netfilter.org>, James Morris <jmorris@redhat.com>,
       "David S. Miller" <davem@davemloft.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@redhat.com
Subject: Re: Netlink connector
Message-ID: <20050726090114.GA870@2ka.mipt.ru>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050726084214.GG7925@rama>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20050726084214.GG7925@rama>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 26 Jul 2005 13:01:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 04:42:14AM -0400, Harald Welte (laforge@netfilter.org) wrote:
> On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris wrote:
> > On Sun, 24 Jul 2005, David S. Miller wrote:
> > >From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > >Date: Sat, 23 Jul 2005 13:14:55 +0400
> > >>Andrew has no objection against connector and it lives in -mm
> > >A patch sitting in -mm has zero significance.
> > 
> > The significance I think is that Andrew is trying to gently encourage some 
> > further progress in the area.
> 
> Patrick McHardy is currently working on some ideas on how to extend
> netlink.
> 
> The fundamental problem that the connector is trying to solve:
> 
> 1) provide more 'groups' (to transport more different kinds of events)
> 2) provide an abstract API for other kernel code, so it doesn't have to
>    know anything about skb's or networking.
> 
> IMHO issue number '1' should (and can) be adressed within netlink.  Wait
> for Patrick's work on this to show up on netdev.  We can then think
> whether the connctor API (or something similar) can be put on top of it.

Fair enough.
Let's do it this way.

> -- 
> - Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
> ============================================================================
>   "Fragmentation is like classful addressing -- an interesting early
>    architectural error that shows how much experimentation was going
>    on while IP was being designed."                    -- Paul Vixie



-- 
	Evgeniy Polyakov
