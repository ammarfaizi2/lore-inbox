Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBGW1X>; Wed, 7 Feb 2001 17:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbRBGW1N>; Wed, 7 Feb 2001 17:27:13 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:18954 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129104AbRBGW1J>; Wed, 7 Feb 2001 17:27:09 -0500
Date: Wed, 7 Feb 2001 14:26:50 -0800
Message-Id: <200102072226.f17MQoD17063@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Stefan Majer <stefan@x-cellent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 and Adaptec Duralan aka Starfire.c 
In-Reply-To: <3A812800.CCDAA7ED@x-cellent.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2001 11:48:32 +0100, Stefan Majer <stefan@x-cellent.com> wrote:
> Hi All
> 
> I installed a Adaptec Quad Port Ethernet Adapter called Quartet64 and
> after compiling 2.4.1
> with starfire support i got the following  messages in syslog 
> 
> after 
> 
> ifconfig eth2 172.17.1.4 netmask 255.255.0.0 up
> 
> Feb  7 11:37:29 cerro kernel: eth2: Internal fault: The skbuff addresses
> do not match in netdev_rx: 242749457 vs. ce781000 / ce781010.

These are harmless, although very annoying. Use the driver from
2.4.1-acXX, it has this and other things fixed. Just copy starfire.c
into your tree/drivers/net, it will work fine.


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
