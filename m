Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbRBEXTf>; Mon, 5 Feb 2001 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRBEXTZ>; Mon, 5 Feb 2001 18:19:25 -0500
Received: from chaos.ao.net ([205.244.242.21]:55049 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S129665AbRBEXTS>;
	Mon, 5 Feb 2001 18:19:18 -0500
Message-Id: <200102052319.f15NJEi19823@vulpine.ao.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0/2.4.1 crashes in ext2 
Date: Mon, 05 Feb 2001 18:19:14 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
> > Ok, here's the crash I'm getting in 2.4.0.  Same thing is happening in 2.4.
1,
> > but It's dying harder so getting syslog info out is tougher.
> 
> What I/O subsystem

Adaptec 2940, although it appears to have been spontainous PCI bus death.

I've never seen a system die like that, so I took a while to rule out
hardware.  CPU didn't overheat, memory didn't go bad, no drives
failed...  even checked the PCI sockets for bad seating.  Nada.  Just...
the motherboard itself died, and only when doing a lot of SCSI I/O.

Rather unusal, it'd been running for a year now without a glitch until
I installed 2.4.  One of those stupid conincidences.

Sorry for the wasted cycles.

--Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
