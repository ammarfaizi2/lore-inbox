Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266086AbRGDRJi>; Wed, 4 Jul 2001 13:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbRGDRJ1>; Wed, 4 Jul 2001 13:09:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266086AbRGDRJN>; Wed, 4 Jul 2001 13:09:13 -0400
Subject: Re: 2.4.6: Machine Check Exception:  0x  106BE0  (type 0x   9).
To: bragason@uni-freiburg.de (David Thor Bragason)
Date: Wed, 4 Jul 2001 18:08:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0107041820070.27099-100000@sun2.ruf.uni-freiburg.de> from "David Thor Bragason" at Jul 04, 2001 06:27:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Hq8x-0001AR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I stress that 2.4.4 still compiles and runs without a problem. Does this
> make any sense for a hardware problem? Was there any new hardware (cpu)
> check introduced in 2.4.5? I'd be very grateful for any tips,

Yes. 2.4.5 reports MCE rather than praying the detected error or out of
tolerance event did anything bad

2.4.6 has a "nomce" boot option too
