Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131170AbRCGUCN>; Wed, 7 Mar 2001 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRCGUCD>; Wed, 7 Mar 2001 15:02:03 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:55303 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131170AbRCGUBu>;
	Wed, 7 Mar 2001 15:01:50 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103072000.XAA12410@ms2.inr.ac.ru>
Subject: Re: Incoming TCP TOS: A simple question, I would have thought...
To: david_luyer@pacific.NET.AU (David Luyer)
Date: Wed, 7 Mar 2001 23:00:59 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103070400.f2740jT16998@typhaon.pacific.net.au> from "David Luyer" at Mar 7, 1 07:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I've scrolled through various code in net/ipv4, and I can't see how to query 
> the TOS of an incoming TCP stream (or at the least, the TOS of the SYN which
> initiated the connection).

No way. Formally it is IP_RECVTOS, followed by IP_PKTOPTIONS.
But getting TOS via IP_PKTOPTIONS is not implemented, only ttl.

Alexey
