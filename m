Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265212AbSJaHh1>; Thu, 31 Oct 2002 02:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbSJaHh0>; Thu, 31 Oct 2002 02:37:26 -0500
Received: from netcore.fi ([193.94.160.1]:17678 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S265212AbSJaHhZ>;
	Thu, 31 Oct 2002 02:37:25 -0500
Date: Thu, 31 Oct 2002 09:43:40 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>, <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>, <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
In-Reply-To: <20021031.163209.595697847.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0210310942030.19356-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> In article <Pine.LNX.4.44.0210310908090.19356-100000@netcore.fi> (at Thu, 31 Oct 2002 09:25:01 +0200 (EET)), Pekka Savola <pekkas@netcore.fi> says:
> 
> > I belive privacy extensions can be harmful for especially long-lived
> > applications and lead to a false sense of security: they should not be
> > enabled (by any definition of enabled) by default.
> 
> Temporary addresses are generated (on most links) but not used by default 
> (latter is done by source address selection) by my patch.  
> Set sysctl net.ipv6.conf.ethXX.use_tempaddr > 1 to use it by default.
> 
> (I have per-application setsockopt interface but it is not included 
>  because patch for source address selection is not accepted at this moment.)

Generating and re-generating new temporary addresses seems to be a useless 
work and just new addresses unless they're being used at least by some 
applications.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

