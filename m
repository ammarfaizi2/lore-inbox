Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269842AbRHWSfC>; Thu, 23 Aug 2001 14:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269967AbRHWSex>; Thu, 23 Aug 2001 14:34:53 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:34568 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269937AbRHWSej>;
	Thu, 23 Aug 2001 14:34:39 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108231834.WAA08213@ms2.inr.ac.ru>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
To: Gunther.Mayer@t-online.de (Gunther Mayer)
Date: Thu, 23 Aug 2001 22:34:48 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B854A28.31C7ACB8@t-online.de> from "Gunther Mayer" at Aug 23, 1 08:23:36 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So we have another way besides several INTs to detect the avail mem :-)

Well, if this memory is available then I guess port 0x1000 is "available"
as well and all the rest of ports are not available. :-)

No, something is rotted in this kingdom.


> Probably PNP0C02 wants to be reserved, too.

What's about these, they are nice port and could be used by our irq handler.
According to docs they replace functionality missing in standard
int. controller ports for this chipset.

What's about passing parameters from bios setup to linux...
This is amusing, but not more. I am sorry, I still prefer to use usual
kernel command line instead of some ugly foreign interface.

Alexey
