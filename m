Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKRD1q>; Fri, 17 Nov 2000 22:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKRD1g>; Fri, 17 Nov 2000 22:27:36 -0500
Received: from quechua.inka.de ([212.227.14.2]:55850 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129171AbQKRD12>;
	Fri, 17 Nov 2000 22:27:28 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Missing ACKs with Linux 2.2/2.4?
Message-Id: <E13weDc-0003xR-00@calista.inka.de>
Date: Fri, 17 Nov 2000 06:37:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200011121600.TAA17075@ms2.inr.ac.ru> you wrote:
> Timestamp is not a random number, so that probability of PAWS failure
> does not depend on restricting it at all. The only thing which can help
> to reduce probability is dropping all tpacket with ts_val==0
> or shutting down your machine while time of your peers passes through zero. 8)

But Timestamps are not increased by one every packet, so the likelyhood that
a wraparound

a) happens  and 
b) happens while a packet is send

is realy small.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
