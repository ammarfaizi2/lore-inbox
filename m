Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTA1HMh>; Tue, 28 Jan 2003 02:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTA1HMh>; Tue, 28 Jan 2003 02:12:37 -0500
Received: from cerberus.stardot-tech.com ([67.105.126.66]:18445 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S267328AbTA1HMg>; Tue, 28 Jan 2003 02:12:36 -0500
Date: Mon, 27 Jan 2003 23:21:45 -0800 (PST)
From: Jim Treadway <jim@stardot-tech.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: "David S. Miller" <davem@nuts.ninka.net>
Subject: Re: [TCP]: Add tcp_low_latency sysctl.
In-Reply-To: <Pine.LNX.4.44.0301272313200.16728-100000@cerberus.stardot-tech.com>
Message-ID: <Pine.LNX.4.44.0301272320070.16728-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Jim Treadway wrote:

> On Mon, 27 Jan 2003, Linux Kernel Mailing List wrote:
> 
> > ChangeSet 1.930.3.1, 2003/01/27 15:51:19-08:00, davem@nuts.ninka.net
> 
> [SNIPPED]
> 
> > diff -Nru a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> > --- a/net/ipv4/sysctl_net_ipv4.c	Mon Jan 27 21:32:28 2003
> > +++ b/net/ipv4/sysctl_net_ipv4.c	Mon Jan 27 21:32:28 2003
> > @@ -223,6 +223,8 @@
> >  	 &sysctl_tcp_tw_reuse, sizeof(int), 0644, NULL, &proc_dointvec},
> >  	{NET_TCP_FRTO, "tcp_frto",
> >  	 &sysctl_tcp_frto, sizeof(int), 0644, NULL, &proc_dointvec},
> > +	{NET_TCP_FRTO, "tcp_low_latency",
> > +	 &sysctl_tcp_low_latency, sizeof(int), 0644, NULL, &proc_dointvec},
> >  	{0}
> >  };
> 
> I think this should be NET_TCP_LOW_LATENCY instead of NET_TCP_FRTO.  I
> don't have a 2.5 kernel here or I'd send a patch, sorry.

Doh just saw the other patch. :O

