Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274136AbRISTMO>; Wed, 19 Sep 2001 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274138AbRISTMH>; Wed, 19 Sep 2001 15:12:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61202 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274136AbRISTLt>; Wed, 19 Sep 2001 15:11:49 -0400
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
To: bruce@ask.ne.jp (Bruce Harada)
Date: Wed, 19 Sep 2001 20:15:57 +0100 (BST)
Cc: greearb@candelatech.com (Ben Greear), linux-kernel@vger.kernel.org
In-Reply-To: <20010920033841.2079e414.bruce@ask.ne.jp> from "Bruce Harada" at Sep 20, 2001 03:38:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jmpB-0003Zn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doubtful. Since it's an 815, I presume you're running a PIII (correct me if
> I'm wrong) - newish PIIIs have reasonable overheating cutout features, and
> if overheating had damaged the CPU, I'd be very surprised if it worked at
> all, rather than just locking up on certain sizes of network packets.

The 815 chipsets have known (and documented) problems with out of spec
memory signals. Board vendors are supposed to have used workarounds but I
have so far sent back 2 out of the 3 A/Open i815 boards with problems where
they locked up occasionally under high load (in any OS) and also failed
memtest86 (with known good tested ram) when placed in an electrically noisy
environment.

I've seen lockups on high network load as part of that - but not packet size
dependant ones.

Alan
