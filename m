Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279815AbRJ3C4X>; Mon, 29 Oct 2001 21:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279829AbRJ3C4O>; Mon, 29 Oct 2001 21:56:14 -0500
Received: from domino1.resilience.com ([209.245.157.33]:20635 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S279815AbRJ3C4C>; Mon, 29 Oct 2001 21:56:02 -0500
Mime-Version: 1.0
Message-Id: <p05100304b803c6908755@[10.128.7.49]>
In-Reply-To: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net>
Date: Mon, 29 Oct 2001 18:55:48 -0800
To: Dan Hollis <goemon@anime.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Ethernet NIC dual homing
Cc: willy tarreau <wtarreau@yahoo.fr>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 6:33 PM -0800 10/29/01, Dan Hollis wrote:
>On Mon, 29 Oct 2001, Christopher Friesen wrote:
>>  Are there issues with using MII to detect link state?  I thought 
>>it was fairly
>>  reliable...
>
>It doesn't work to detect link state through bridging device (say, bridged
>ethernet over T3). The T3 might go down, but your MII link to the local
>router will remain "up", so you will never know about the loss of link and
>your packets will happily go into the void...

ARP isn't going to do much for you once the failure is beyond the 
local segment, is it?
-- 
/Jonathan Lundell.
