Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQLNHZX>; Thu, 14 Dec 2000 02:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQLNHZO>; Thu, 14 Dec 2000 02:25:14 -0500
Received: from relay.inway.cz ([212.24.128.3]:33040 "EHLO tac.inway.cz")
	by vger.kernel.org with ESMTP id <S129518AbQLNHZB> convert rfc822-to-8bit;
	Thu, 14 Dec 2000 02:25:01 -0500
Message-ID: <007001c0659a$a0a17a40$a49418d4@shredder>
From: "Petr Sebor" <petr@scssoft.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0012132205250.5935-100000@winds.org> <3A3855C4.B997ACFC@home.com>
Subject: Re: 2.4.0-test12 randomly hangs up
Date: Thu, 14 Dec 2000 07:53:55 +0100
Organization: SCS Software
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe it's the 3.3.6.  RH 7.0 comes with 4.0.1, and a newer glibc. 
> Perhaps try recompiling XFree86 against the latest RH 7.0 glibc (2.1.94)
> and see what happens, or upgrade your XFree86 to the standard RH 7.0
> XFree86 4.0.1.
> 
> -- 
> Matthew Vanecek

Nope, it dies even with my handbuilt XFree86 4.0.1 DRI (Slack7.0) on 
plain KDE2.0.1. I have no extra patches in kernel and quite common HW 
[ Celeron 433, 192MB of RAM, 13GB HDD ( ext2 & vfat partitioned ),
PCI NE2000 NIC, ES1371 sound, Intel BX chipset board and ATI 
Radeon32DDR - maybe the new MTRR stuff is not working right ? ] At 
least it was running fine with test11 and with test11-ac4

Regards,
Petr


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
