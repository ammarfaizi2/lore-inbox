Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSH1OVQ>; Wed, 28 Aug 2002 10:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318851AbSH1OVQ>; Wed, 28 Aug 2002 10:21:16 -0400
Received: from mail.coastside.net ([207.213.212.6]:59265 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S318850AbSH1OVP>; Wed, 28 Aug 2002 10:21:15 -0400
Mime-Version: 1.0
Message-Id: <p05111a13b9928cf63a15@[10.2.2.25]>
In-Reply-To: <20020828074148.B23738@hq.fsmlabs.com>
References: <20020827145631.B877@hq.fsmlabs.com>
 <Pine.LNX.3.95.1020828080308.14759A-101000@chaos.analogic.com>
 <20020828074148.B23738@hq.fsmlabs.com>
Date: Wed, 28 Aug 2002 07:25:01 -0700
To: yodaiken@fsmlabs.com, "Richard B. Johnson" <root@chaos.analogic.com>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: interrupt latency
Cc: yodaiken@fsmlabs.com, Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:41 am -0600 8/28/02, yodaiken@fsmlabs.com wrote:
>Average and worst case are different.

I can believe that. The explanation that jumps to mind is PCI bus 
contention because of DMA, causing the inb to stall or to get 
repeatedly retried. 13us seems a little extreme, but not completely 
impossible.
-- 
/Jonathan Lundell.
