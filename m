Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269589AbRHCUHG>; Fri, 3 Aug 2001 16:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269587AbRHCUGq>; Fri, 3 Aug 2001 16:06:46 -0400
Received: from [64.175.255.50] ([64.175.255.50]:1693 "HELO kobayashi.soze.net")
	by vger.kernel.org with SMTP id <S269583AbRHCUGj>;
	Fri, 3 Aug 2001 16:06:39 -0400
Date: Fri, 3 Aug 2001 13:06:20 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Anders Eriksson <aer-list@mailandnews.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: link status changes forwarded to userspace?
In-Reply-To: <200108031958.f73JwGf12358@milou.dyndns.org>
Message-ID: <Pine.LNX.4.33.0108031303080.17167-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Anders Eriksson wrote:

> Is it possible to get the link status change (e.g. eth cable inserted in card)
> forwarded to userspace? I'd be cool to auto trigger dhcp on connect and
> silently skip the interface if no cable during boot.

you can get the link status from userspace, and that should be enough to
skip no-link interfaces during boot.  mii-tool does it (comes with
net-tools).

justin

