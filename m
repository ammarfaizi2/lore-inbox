Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269401AbUINMmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269401AbUINMmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUINMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:40:20 -0400
Received: from stingr.net ([212.193.32.15]:35252 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S269406AbUINMj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:39:57 -0400
Date: Tue, 14 Sep 2004 16:39:51 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Lincoln Dale <ltd@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paul P Komkoff Jr <i@stingr.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-ID: <20040914123951.GL4141@stingr.sgu.ru>
Mail-Followup-To: Lincoln Dale <ltd@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paul P Komkoff Jr <i@stingr.net>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040913051706.GB26337@stingr.sgu.ru> <20040911194108.GS28258@stingr.sgu.ru> <20040912170505.62916147.davem@davemloft.net> <20040913051706.GB26337@stingr.sgu.ru> <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040914184652.03e24de0@171.71.163.14>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Lincoln Dale:
> the logic is correct, but it may make sense to call the appropriate 
> netfilter hook again with the "unwrapped" GRE packet, as otherwise 
> packets-inside-GRE represent a possible security hole where one can inject 
> packets externally and bypass firewall rules.

>From what I observe, netfilter hooks *are* called for unwrapped packets.
Either for usual IP packets  passed from GRE tunnel, or for demangled
wccp packets.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
