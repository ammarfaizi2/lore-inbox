Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269313AbRHGTIS>; Tue, 7 Aug 2001 15:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRHGTII>; Tue, 7 Aug 2001 15:08:08 -0400
Received: from anime.net ([63.172.78.150]:61707 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S269313AbRHGTIB>;
	Tue, 7 Aug 2001 15:08:01 -0400
Date: Tue, 7 Aug 2001 12:07:48 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: David Ford <david@blue-labs.org>
cc: <landley@webofficenow.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RP_FILTER runs too late
In-Reply-To: <3B702E09.8030207@blue-labs.org>
Message-ID: <Pine.LNX.4.30.0108071206190.3304-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, David Ford wrote:
> I'd rather see SNAT available in pre-routing and have rp_filter run
> against the packet before it hits the netfilter code.

There is one other problem with rp_filter.... rp_filter violations are
S I L E N T. You never know when traffic is dropped because of it. Packets
just disappear.

If it generated printk's it would make it a lot easier to track down
filtering problems.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

