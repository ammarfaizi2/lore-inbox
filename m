Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbTAIWNO>; Thu, 9 Jan 2003 17:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268041AbTAIWNO>; Thu, 9 Jan 2003 17:13:14 -0500
Received: from home.wiggy.net ([213.84.101.140]:29093 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S268042AbTAIWNN>;
	Thu, 9 Jan 2003 17:13:13 -0500
Date: Thu, 9 Jan 2003 23:21:55 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030109222155.GE22951@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20030108150201.GA30490@wiggy.net> <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv> <20030108170139.GL22951@wiggy.net> <1042150352.4688.15.camel@devil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042150352.4688.15.camel@devil>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Mika Liljeberg wrote:
> Looking at your trace it seems that the receiving machine is dropping
> all packets that do not have traffic class set. Note that all segments
> received with [class 0x2] get properly acked. The others probably don't
> get to TCP at all. You might want to check your filters and QoS
> policies.

I don't have any filters and QoS support isn't even enabled in this
kernel.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
