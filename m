Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTAHQw7>; Wed, 8 Jan 2003 11:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbTAHQw7>; Wed, 8 Jan 2003 11:52:59 -0500
Received: from home.wiggy.net ([213.84.101.140]:18921 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267633AbTAHQw6>;
	Wed, 8 Jan 2003 11:52:58 -0500
Date: Wed, 8 Jan 2003 18:01:39 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, netdev@oss.sgi.com
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108170139.GL22951@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>, netdev@oss.sgi.com
References: <20030108150201.GA30490@wiggy.net> <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Maciej Soltysiak wrote:
> I seem to be getting better results than you, i think that it is not an
> issue of ipv6 implementation but simply the case of time sensitive
> traffic fighting with other Internet traffic over tunnels through ipv4
> networks.

Actually, I don't follow this. How could any kind of traffic shaping
result in my client not sending ACKs, which is what the tcpdump
seems to indicate? I can understand packets being dropped which
would result in retransmits, but that is not the case here.

Wichert.

(usual I'm-no-network-guru-and-might-be-misreading-things disclaimer here)

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
