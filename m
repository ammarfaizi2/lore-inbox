Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQKHRmb>; Wed, 8 Nov 2000 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbQKHRmU>; Wed, 8 Nov 2000 12:42:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31536 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129190AbQKHRmP>; Wed, 8 Nov 2000 12:42:15 -0500
Subject: Re: continuing VM madness
To: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka)
Date: Wed, 8 Nov 2000 17:42:33 +0000 (GMT)
Cc: jamagallon@able.es (J . A . Magallon),
        rothwell@holly-springs.nc.us (Michael Rothwell),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001108174731.7153B-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Nov 08, 2000 05:58:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tZF5-0000EX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sadly it is not a bug but a VM misdesign (and people are just making
> different workarounds that more or less work). I believe that this
> solution will break again, as it happened in 2.2.15 and 2.2.16.

2.2.15->16 was the major transition in getting stuff right. 2.2.18 should be
pretty reasonable. With Andrea's additional patches its quite nice. If we
add page aging then in theory it'll be as good as 2.2 but in practice who 
knows

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
