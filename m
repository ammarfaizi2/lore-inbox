Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130453AbQKPPhE>; Thu, 16 Nov 2000 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbQKPPgy>; Thu, 16 Nov 2000 10:36:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59186 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130453AbQKPPgq>; Thu, 16 Nov 2000 10:36:46 -0500
Subject: Re: Modprobe local root exploit
To: Torsten.Duwe@caldera.de
Date: Thu, 16 Nov 2000 15:07:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <14867.60258.282676.883552@ns.caldera.de> from "Torsten Duwe" at Nov 16, 2000 03:12:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wQdN-0007u0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd consider it "system internal", not visible to the user and hence 7-Bit
> must suffice. I also strongly agree with Keith: treating strings that come
> from the kernel as tainted is weird at least.

I would consider it to be an arbitary 8bit bytesequence. Fix the user space

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
