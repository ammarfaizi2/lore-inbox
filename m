Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279833AbRJ3DbI>; Mon, 29 Oct 2001 22:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279834AbRJ3Da6>; Mon, 29 Oct 2001 22:30:58 -0500
Received: from intranet.resilience.com ([209.245.157.33]:36251 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S279833AbRJ3Dao>; Mon, 29 Oct 2001 22:30:44 -0500
Mime-Version: 1.0
Message-Id: <p05100309b803cdfa4552@[10.128.7.49]>
In-Reply-To: <9rl60r$g50$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net>
 <p05100304b803c6908755@[10.128.7.49]> <9rl60r$g50$1@cesium.transmeta.com>
Date: Mon, 29 Oct 2001 19:30:52 -0800
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Ethernet NIC dual homing
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:15 PM -0800 10/29/01, H. Peter Anvin wrote:
>  > ARP isn't going to do much for you once the failure is beyond the
>>  local segment, is it?
>>
>
>ARP is broadcast to the layer 2 local segment; link detection refers
>to the layer 1 local segment, which is not necessarily the same.
>
>On the other hand, doing link detection is extremely useful for a
>portable computer: when I plug in my Ethernet cable in a portable
>system I want it to try to start doing DHCP detection and anything
>else that is normally associated with the interface being "up" at that
>time.

I'm not planning to use bonding on my notebook any time soon.

But what I meant was bonding's use of ARP to determine whether the 
connection is good (or rather, bad, even when the link is up), when 
the connection is routed via level 3. Seems to me you'd need a level 
3 protocol (say ICMP) rather than ARP.
-- 
/Jonathan Lundell.
