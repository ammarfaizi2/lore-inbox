Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTAHOzY>; Wed, 8 Jan 2003 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267903AbTAHOzY>; Wed, 8 Jan 2003 09:55:24 -0500
Received: from home.wiggy.net ([213.84.101.140]:9700 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267902AbTAHOzX>;
	Wed, 8 Jan 2003 09:55:23 -0500
Date: Wed, 8 Jan 2003 16:02:01 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108150201.GA30490@wiggy.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030108130850.GQ22951@wiggy.net> <Pine.LNX.4.44.0301081535460.27551-100000@dns.toxicfilms.tv> <20030108145211.GD22951@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108145211.GD22951@wiggy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Wichert Akkerman wrote:
> traceroute to ipv6.lkml.org (2001:968:1::2) from
> 3ffe:8280:10:1d0:290:27ff:fe2d:968c, 30 hops max, 16 byte packets
>  1  thunder.wiggy.net (3ffe:8280:10:1d0:250:4ff:fe0b:dd79)  0.666 ms 0.22 ms  0.199 ms
>  2  xs4all-29.ipv6.xs4all.nl (3ffe:8280:0:2001::58)  27.568 ms  28.012 ms  30.177 ms
>  3  26.ge-0-2-0.xr1.pbw.xs4all.net (2001:888:0:3::1)  22.035 ms 19.528 ms  44.644 ms
>  4  0.ge-0-3-0.xr1.sara.xs4all.net (2001:888:2:1::1)  19.519 ms 19.002 ms  21.974 ms
>  5  fe-0-0-0.ams-core-01.network6.isp-services.nl (2001:7f8:1::a502:4875:1)  19.978 ms  30.278 ms  20.248 ms
>  6  2001:968::2 (2001:968::2)  24.246 ms  24.083 ms  22.918 ms
>  7  2001:968:1::2 (2001:968:1::2)  24.978 ms  23.866 ms  23.661 ms
> 
> thunder.wiggy.net is my Linux router running 2.4.19-pre5-ac3-freeswan196
> currently. The second hop is a normal sit tunnel and all the other
> hops are native ipv6 using Cisco and Juniper routers as far as I know.

Slight correction to that: xs4all-29.ipv6.xs4all.nl is a FreeBSD-4.5
tunnel server. The toher xs4all.net hops are Junipers running JunOS 5.3
or 5.5.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
