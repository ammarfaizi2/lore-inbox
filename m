Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267519AbTAHQfQ>; Wed, 8 Jan 2003 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbTAHQfQ>; Wed, 8 Jan 2003 11:35:16 -0500
Received: from home.wiggy.net ([213.84.101.140]:4329 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267519AbTAHQfP>;
	Wed, 8 Jan 2003 11:35:15 -0500
Date: Wed, 8 Jan 2003 17:43:47 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108164347.GK22951@wiggy.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030108150201.GA30490@wiggy.net> <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Maciej Soltysiak wrote:
> I do not know how many tunnels are in my path, i know that hop distance to
> my tunnel is exactly 1 hop (ipv6 broker and ipv4 provider are the same)

My tunnel provider is 5 hops away. To my knowledge non of the ipv4 or
ipv6 hops in the path are congested and no traffic shaping is done.

> If there is immense traffic at one of the routers (total traffic on an
> interface) stream packets can be simply dropped if there are no queuing
> disciplines that would take eg. flow control into account.

I'll ask the ISPs involved to check if this might be happening, but I
highly doubt it.

> btw. what the hell is JunOs ?

Juniper OS, running on Juniper routers.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
