Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbQKRClC>; Fri, 17 Nov 2000 21:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQKRCkw>; Fri, 17 Nov 2000 21:40:52 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59657 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131228AbQKRCkm>; Fri, 17 Nov 2000 21:40:42 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGA PCI IO port reservations
Date: 17 Nov 2000 18:10:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v4oe5$vbl$1@cesium.transmeta.com>
In-Reply-To: <200011172002.UAA01918@raistlin.arm.linux.org.uk> <Pine.LNX.3.95.1001117150349.23529A-100000@chaos.analogic.com> <20001117202009.B2472@zalem.puupuu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001117202009.B2472@zalem.puupuu.org>
By author:    Olivier Galibert <galibert@pobox.com>
In newsgroup: linux.dev.kernel
> 
> What guarantees you that:
> 1- No device will respond 0xffff for an address it decodes
> 2- No device will crap up on you simply because you've read one
> particular address
> 
> If any of these if true for any device out there (I think I have one
> in my computer that does the 1/ part in some cases), your code is
> unsafe.
> 

It is.  There are plenty of devices for which an arbitrary IN is an
irrecoverable state transition.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
