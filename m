Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130848AbRBNUmG>; Wed, 14 Feb 2001 15:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRBNUls>; Wed, 14 Feb 2001 15:41:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130848AbRBNUln>; Wed, 14 Feb 2001 15:41:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ECN for servers ?
Date: 14 Feb 2001 12:41:26 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <96eqhm$33k$1@cesium.transmeta.com>
In-Reply-To: <20010214190128.G923@ppetru.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010214190128.G923@ppetru.net>
By author:    Petru Paler <ppetru@ppetru.net>
In newsgroup: linux.dev.kernel
>
> Hello,
> 
> What is the impact of enabling ECN on the server side ? I mean, will
> any clients (with broken firewalls) be affected if a SMTP/HTTP server
> has ECN enabled ?
> 
> On the other hand, is there any advantage with ECN enabled on the server
> side ?
> 

Pro: better behaviour in presence of network congestion.

Con: people behind broken firewalls can't connect.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
