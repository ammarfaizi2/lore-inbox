Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUIVPgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUIVPgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUIVPgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:36:17 -0400
Received: from slartibartfast.pa.net ([66.59.111.182]:26765 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S266155AbUIVPgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:36:14 -0400
Date: Wed, 22 Sep 2004 11:31:51 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Martin Josefsson <gandalf@wlug.westbo.se>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>,
       ML-netfilter-devel <netfilter-devel@lists.netfilter.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       William Stearns <wstearns@pobox.com>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0409221110260.3523@sparrow>
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
 <1095803902.1942.211.camel@bach> <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
 <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se>
 <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,

On Wed, 22 Sep 2004, Richard B. Johnson wrote:

> On Wed, 22 Sep 2004, Martin Josefsson wrote:
> 
> > On Wed, 22 Sep 2004, Richard B. Johnson wrote:
> >
> > > What replaces the firewall stuff? It can't just "go away"!
> >
> > Ever heard of iptables?
> 
> I guess I'll have to convert 1340 lines of ipchains commands to
> iptables -yech!

	I have a script that does a first pass of converting an ipchains 
firewall script to an iptables firewall script at 

http://www.stearns.org/i2i/ipchains2iptables
http://www.stearns.org/i2i/ipchains2iptables.README

	Because of architectural differences between the two firewall 
technologies it can't produce a perfect translation, but it does handle 
most of the grunt work.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "The sign on the window next to the entrance of OptInRealBig's
offices in Westminster leaves no room for misunderstanding.  Or irony.
NO SOLICITING."
http://www.westword.com/issues/2004-01-29/feature.html/3/index.html
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
