Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265674AbRF1Mwd>; Thu, 28 Jun 2001 08:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265678AbRF1MwX>; Thu, 28 Jun 2001 08:52:23 -0400
Received: from zbt61.eastnet.gatech.edu ([128.61.107.189]:7808 "EHLO pinky")
	by vger.kernel.org with ESMTP id <S265673AbRF1MwK>;
	Thu, 28 Jun 2001 08:52:10 -0400
Date: Thu, 28 Jun 2001 08:52:03 -0400
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
Message-ID: <20010628085203.B744@zarq.dhs.org>
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
User-Agent: Mutt/1.3.18i
From: rc@zarq.dhs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 07:28:23PM +0200, kees wrote:
> Hi,
> 
> I tried 2.4.5 but after a couple of hours I lost all network connectivety.
> The log shows:
> 
> 
> Jun 25 19:34:17 schoen3 kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jun 25 19:34:17 schoen3 kernel: eth0: Tx timed out, lost
> interrupt? TSR=0x3, ISR=0Jun 25 19:34:19 schoen3 kernel: NETDEV
> WATCHDOG: eth0: transmit timed out
> Jun 25 19:34:19 schoen3 kernel: eth0: Tx timed out, lost
> interrupt? TSR=0x3, ISR=0Jun 25 19:34:21 schoen3 kernel: NETDEV
> WATCHDOG: eth0: transmit timed out
> Jun 25 19:34:21 schoen3 kernel: eth0: Tx timed out, lost
> interrupt? TSR=0x3, ISR=0/tmp/NETDEV

Known bug, been there since at least 2.4.0-test11.  There was a patched
2.4.2 that worked well here, as well as 2.4.5-ac17 (Though I haven't tested
2.4.5-ac17 as long as the patched 2.4.2).

R C
