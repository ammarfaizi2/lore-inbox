Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbRG2ByZ>; Sat, 28 Jul 2001 21:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbRG2Bxx>; Sat, 28 Jul 2001 21:53:53 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:60905 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267452AbRG2Bxo>; Sat, 28 Jul 2001 21:53:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
Date: Sat, 28 Jul 2001 20:53:48 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <20010729133848.A3254@weta.f00f.org>
In-Reply-To: <20010729133848.A3254@weta.f00f.org>
Cc: Chris Wedgwood <cw@f00f.org>
MIME-Version: 1.0
Message-Id: <01072820534802.01125@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

No, and no errors are shown for it either:

# ifconfig lo
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:196907 errors:0 dropped:0 overruns:0 frame:0
          TX packets:196907 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

All *seems* well.  Just that 30-second period of messages and then silence.

Thanks for the response.


On Saturday 28 July 2001 08:38 pm, you wrote:
> is lo down?
>
>   --cw
>
> On Sat, Jul 28, 2001 at 08:23:14PM -0500, Steve Snyder wrote:
>     I just got this sequence of messages in my system log:
>
>     Jul 28 19:47:44 sunburn kernel: Neighbour table overflow.
>     Jul 28 19:47:44 sunburn last message repeated 9 times
>     Jul 28 19:47:49 sunburn kernel: NET: 53 messages suppressed.
>     Jul 28 19:47:49 sunburn kernel: Neighbour table overflow.
>     Jul 28 19:48:07 sunburn kernel: NET: 21 messages suppressed.
>     Jul 28 19:48:07 sunburn kernel: Neighbour table overflow.
>     Jul 28 19:48:09 sunburn last message repeated 3 times
>     Jul 28 19:48:14 sunburn kernel: NET: 4 messages suppressed.
>     Jul 28 19:48:14 sunburn kernel: Neighbour table overflow.
>
>     This is on a RedHat v7.1 + SMP kernel v2.4.7 system.  What is the
> kernel trying to tell me here?
>
>     Please cc me as I am not a subscriber to this list.
>
>     Thanks.
>     -
>     To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     Please read the FAQ at  http://www.tux.org/lkml/
