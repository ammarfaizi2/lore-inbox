Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBHMUH>; Thu, 8 Feb 2001 07:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131171AbRBHMT5>; Thu, 8 Feb 2001 07:19:57 -0500
Received: from [64.160.188.242] ([64.160.188.242]:24591 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129051AbRBHMTq>; Thu, 8 Feb 2001 07:19:46 -0500
Date: Thu, 8 Feb 2001 04:19:41 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: APIC errors with 2.4.2-pre1
Message-ID: <Pine.LNX.4.30.0102080417050.30734-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, talked with someone who knows a little more about this than i do.
According to him, one reason I may be getting these errors is due to the
fact that the HPT370 controller is using IRQ18 which falls in the APIC
extended IRQ range (16 - 31).

If this is a problem is there a work-around? I don't know how to change
the IRQ the HPT370 is using since it's an onboard card.

-- 
David D.W. Downey - RHCE
Consulting Engineer
Ensim Corporation - Sunnyvale, CA

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
