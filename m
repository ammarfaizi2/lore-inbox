Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129296AbRBLXVc>; Mon, 12 Feb 2001 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRBLXVW>; Mon, 12 Feb 2001 18:21:22 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:64521 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S129296AbRBLXVQ>; Mon, 12 Feb 2001 18:21:16 -0500
Date: Mon, 12 Feb 2001 23:22:53 +0000 (GMT)
From: Chris Funderburg <chris@Funderburg.com>
To: <scott@spiteful.org>
cc: <linux-kernel@vger.kernel.org>
Subject: opl3sa not detected anymore
Message-ID: <Pine.LNX.4.30.0102122311180.1057-100000@pikachu.bti.com>
X-Unexpected-Header: Hello!!!
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After the updates to the opl3sa2 driver (2.4.2-pre3?) my card isn't being
detected anymore.  Are there further updates to come, or do I need to
change the settings?  The driver is being loaded as a module with the
following in /etc/modules.conf:

alias sound-slot-0 opl3sa2
options sound dmabuf=1
alias midi opl3
options opl3 io=0x388
options opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370

The midi works fine, but 'modprobe sound' reports:

opl3sa2: No cards found
opl3sa2: 0 PnP card(s) found.

If the settings above look ok, then how can help debug it?

Regards
CF
-- 
... Any resemblance between the above views and those of my employer,
my terminal, or the view out my window are purely coincidental.  Any
resemblance between the above and my own views is non-deterministic.  The
question of the existence of views in the absence of anyone to hold them
is left as an exercise for the reader.  The question of the existence of
the reader is left as an exercise for the second god coefficient.  (A
discussion of non-orthogonal, non-integral polytheism is beyond the scope
of this article.)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
