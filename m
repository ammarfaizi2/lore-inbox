Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbQKPRtv>; Thu, 16 Nov 2000 12:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbQKPRtl>; Thu, 16 Nov 2000 12:49:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35388 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131200AbQKPRth>; Thu, 16 Nov 2000 12:49:37 -0500
Subject: Re: Local root exploit with kmod and modutils > 2.1.121
To: kuznet@ms2.inr.ac.ru
Date: Thu, 16 Nov 2000 17:19:45 +0000 (GMT)
Cc: alan@lxorguk.UKuu.ORG.UK (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200011161705.UAA03238@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Nov 16, 2000 08:05:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wShQ-000860-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.UKuu.ORG.UK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It checks CAP_SYS_MODULE nowadays.
> 
> Which does not look good by the way, it is function of request_module(),
> rather than of caller.

Only the caller knows if the data is tainted. Thus only the caller can decide

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
