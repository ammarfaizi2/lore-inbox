Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269908AbRHEDUg>; Sat, 4 Aug 2001 23:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269909AbRHEDUZ>; Sat, 4 Aug 2001 23:20:25 -0400
Received: from butterblume.comunit.net ([192.76.134.57]:19985 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S269908AbRHEDUT>; Sat, 4 Aug 2001 23:20:19 -0400
Date: Sun, 5 Aug 2001 05:19:55 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: Mircea Ciocan <mirceac@interplus.ro>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ip_conntrack bigger, better and yellow ;) !!!
In-Reply-To: <3B6C9CC0.819CA53C@interplus.ro>
Message-ID: <Pine.LNX.4.33.0108050517180.5123-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001, Mircea Ciocan wrote:

> 	Ok, the pressure for a netflow like stuff in kernel is big, examining
> the the netflow structure at:
>
>  http://sgi.rdscv.ro/~ionuts/netflowv5.h
>
> it seem that ip_conntrak has allmost everything that is needed to
> emulate Cisco netflow EXCEPT ( a big except :) the information about
> data bytes/packets that flow via that connexion and the question is how
> could be added with minimum damages, for example at the end of the
> existing ip_conntrack structure, so a nice little userspace daemon could
> parse the /proc/net/ip_conntrack and generate the damned netflow packets
> that everybody seem to want now :( !!!

I think you should get in contact with the netfilter-coreteam about this
and subscribe to the netfilter-devel-mailinglist - see
http://netfilter.samba.org/ for subscribe-information.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

