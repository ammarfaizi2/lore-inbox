Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSJXFxR>; Thu, 24 Oct 2002 01:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJXFxQ>; Thu, 24 Oct 2002 01:53:16 -0400
Received: from netcore.fi ([193.94.160.1]:32777 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S265321AbSJXFxK>;
	Thu, 24 Oct 2002 01:53:10 -0400
Date: Thu, 24 Oct 2002 08:59:16 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: usagi@linux-ipv6.org, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] IPv6: Sysctl for ICMPv6 Rate Limitation
In-Reply-To: <20021024.145551.130454003.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0210240858060.8872-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <Pine.LNX.4.44.0210240847280.8872-100000@netcore.fi> (at Thu, 24 Oct 2002 08:50:25 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> 
> > > +icmp/*:
> > > +ratelimit - INTEGER
> > > +	Limit the maximal rates for sending ICMPv6 packets.
> > > +	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
> > > +	Default: 100
> > > +
> > 
> > Does this rate-limit all ICMPv6 packets or just ICMPv6 error messages (as 
> > specified in ICMPv6 specifications).
> > 
> > If all, I believe the default of rate-limiting everything is unacceptable.
> 
> This patch just adds sysctl.  It is my documentation error...
> is s/ICMPv6 packets/ICMPv6 error packets/ ok?
> 
> (I need to do s/100/HZ/, too; This also lives in ICMP(v4)).

That change fine with me, thanks.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


