Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVGYHJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVGYHJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVGYHHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:07:05 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62368 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261636AbVGYHGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:06:41 -0400
Date: Mon, 25 Jul 2005 11:06:04 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Harald Welte <laforge@netfilter.org>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@redhat.com,
       netdev@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050725070603.GA28023@2ka.mipt.ru>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 25 Jul 2005 11:06:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris (jmorris@redhat.com) wrote:
> On Sun, 24 Jul 2005, David S. Miller wrote:
> >From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> >Date: Sat, 23 Jul 2005 13:14:55 +0400
> >
> >>Andrew has no objection against connector and it lives in -mm
> >
> >A patch sitting in -mm has zero significance.

That is why I'm asking netdev@ people again...

> The significance I think is that Andrew is trying to gently encourage some 
> further progress in the area.
>
> I recall some netconf discussion about TIPC over Netlink, or more likely a 
> variation thereof, which may be a better way forward.
> 
> It's cool stuff http://tipc.sourceforge.net/

I read it quite long ago - I'm sure you do not want to use that monster
for event bus.
It was designed and implemented for heavy intermachine communications,
and it is quite hard to setup for userspace <-> kernelspace message bus.

> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>

-- 
	Evgeniy Polyakov
