Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135401AbRDMErZ>; Fri, 13 Apr 2001 00:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135403AbRDMErF>; Fri, 13 Apr 2001 00:47:05 -0400
Received: from altus.drgw.net ([209.234.73.40]:3088 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S135401AbRDMEq5>;
	Fri, 13 Apr 2001 00:46:57 -0400
Date: Thu, 12 Apr 2001 23:46:26 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Sebastian Klemke <packet@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in natsemi driver 1.07 for linux 2.4.2
Message-ID: <20010412234626.A13920@altus.drgw.net>
In-Reply-To: <20010330070429.A20125@teenix.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010330070429.A20125@teenix.convergence.de>; from packet@convergence.de on Fri, Mar 30, 2001 at 07:04:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2001 at 07:04:29AM +0200, Sebastian Klemke wrote:
> Hi!
> 
> The driver for the natsemi NIC does not properly filter out requested
> multicast groups when in multicast mode.  Multicast groups I joined
> are simply dropped by the MAC address filter of the card, the kernel
> filters them correctly in allmulti or promiscuous mode. I've tested
> driver versions 1.05 which comes with linux 2.4.2, an older version
> that came with linux-2.4.0test12 and 1.07 which came with 2.4.2-ac20.
> 
> I contacted Donald Becker and he told me to post it here.

Have you tried Donald Becker's version of the driver under linux 2.2.x?

The only natsemi driver I've ever had come close to working is in
2.4.4pre1, and even then it's got some problems that cause poor
perfomance, nfs timeouts, and dropped connections with the squid http
proxy.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
