Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRBIXTM>; Fri, 9 Feb 2001 18:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131011AbRBIXTC>; Fri, 9 Feb 2001 18:19:02 -0500
Received: from nga.com ([198.68.22.250]:24815 "EHLO c2_dmz.nga.com")
	by vger.kernel.org with ESMTP id <S130243AbRBIXSt>;
	Fri, 9 Feb 2001 18:18:49 -0500
Message-ID: <3A847A56.922ED4D@nga.com>
Date: Fri, 09 Feb 2001 15:16:38 -0800
From: Tom Popowski <tom@nga.com>
Organization: Northwest Geophysical Associates, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FA-311 / Natsemi problems with 2.4.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me, as I don't follow the list.

Please also forgive me if I'm stepping on toes.  I'm in user-space.

I have had similar problems (network server XXXX not responding) with
both a Netgear FA311 (DP83815) and a Macronix (tulip) card when using
Donald Becker's drivers under 2.2.x  kernels when connected to a Netgear
FE108 (100BaseTx-HD) hub.  Both work correctly when dumbed-down to
10Mb.  The fa311 driver from Netgear worked fine at 100Mb with a 2.2
kernel.

Under 2.4.x, fa311 doesn't compile and natsemi.c gives the messages
below.  Again, I can (and do) force the card to 10Mb and it works fine
with the natsemi driver.

> I'm having problems with the natsemi drivers on my Netgear FA-311 card.
>
> On one host, I get lots of messages like this:
>
> eth1: Something Wicked happened! 0700.
> eth1: Something Wicked happened! 0740.
> eth1: Something Wicked happened! 0740.
> eth1: Something Wicked happened! 0740.
> eth1: Something Wicked happened! 0740.
> eth1: Something Wicked happened! 0740.
> eth1: Something Wicked happened! 0540.
>
--
Tom Popowski
Software Support
Northwest Geophysical Associates, Inc.
http://www.nga.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
