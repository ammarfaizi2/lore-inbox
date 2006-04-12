Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWDLWnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWDLWnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWDLWnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:43:17 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:52206 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932375AbWDLWnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:43:16 -0400
In-Reply-To: <20060412221437.GA20899@havoc.gtf.org>
References: <20060412221437.GA20899@havoc.gtf.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <53E69375-551D-41FC-9D09-E3D39EC80A19@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git patches] net driver fixes
Date: Wed, 12 Apr 2006 17:43:22 -0500
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

Noticed Andy's gianfar fixes aren't in here.  I'd be good to see if  
we can get them in for 2.6.17

- kumar


On Apr 12, 2006, at 5:14 PM, Jeff Garzik wrote:

>
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>
> to receive the following updates:
>
>  drivers/net/b44.c             |   64 ++++++---------
>  drivers/net/bnx2.c            |    2
>  drivers/net/hydra.h           |  177  
> ------------------------------------------
>  drivers/net/ixgb/ixgb_main.c  |   13 ++-
>  drivers/net/mv643xx_eth.c     |   19 +++-
>  drivers/net/natsemi.c         |    2
>  drivers/net/pcmcia/axnet_cs.c |    2
>  drivers/net/skge.c            |    2
>  drivers/net/sky2.c            |    6 -
>  drivers/net/sky2.h            |    2
>  drivers/net/starfire.c        |    2
>  drivers/net/typhoon.c         |    2
>  drivers/net/via-rhine.c       |    7 -
>  13 files changed, 67 insertions(+), 233 deletions(-)
>
> Adrian Bunk:
>       drivers/net/via-rhine.c: make a function static
>       remove drivers/net/hydra.h
>
> Andreas Schwab:
>       Use pci_set_consistent_dma_mask in ixgb driver
>
> Brent Cook:
>       mv643xx_eth: Always free completed tx descs on tx interrupt
>
> Dale Farnsworth:
>       mv643xx_eth: Fix tx_timeout to only conditionally wake tx queue
>
> Gary Zambrano:
>       b44: disable default tx pause
>       b44: increase version to 1.00
>
> Jeff Garzik:
>       [netdrvr b44] trim trailing whitespace
>
> Komuro:
>       network: axnet_cs.c: add missing 'PRIV' in ei_rx_overrun
>
> Randy Dunlap:
>       net drivers: fix section attributes for gcc
>
> Roger Luethi:
>       via-rhine: execute bounce buffers code on Rhine-I only
>
> Stephen Hemminger:
>       dlink pci cards using wrong driver
>       sky2: bad memory reference on dual port cards

