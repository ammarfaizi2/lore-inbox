Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132337AbRDUA1V>; Fri, 20 Apr 2001 20:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132338AbRDUA1L>; Fri, 20 Apr 2001 20:27:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44297 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132337AbRDUA1G>; Fri, 20 Apr 2001 20:27:06 -0400
Subject: Re: Athlon problem report summary
To: lkml@sigkill.net (Disconnect)
Date: Sat, 21 Apr 2001 01:28:28 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010420202235.B20176@sigkill.net> from "Disconnect" at Apr 20, 2001 08:22:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qlGJ-0002b8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oddness. Is it all on that same via chipset? (I have seen some reports of
> the same chipset working on other mobos.)

Variants of the VIA chipset. But I have reports of works/not working from
the same board even.

> Is there a way to enable everything-K7-except-MMX? (Or, for that matter,
> an easy way to see what K7 does that K6 doesn't.)

K7 optimisation basically enabled the MMX copy/clear code which adds 30-40%
performance to those functions. It also materially ups the maximum memory
bandwidth the processor will use which may be where the fun starts.



