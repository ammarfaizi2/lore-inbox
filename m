Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbQLXWXW>; Sun, 24 Dec 2000 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbQLXWXM>; Sun, 24 Dec 2000 17:23:12 -0500
Received: from smtp1.free.fr ([212.27.32.5]:47877 "EHLO smtp1.free.fr")
	by vger.kernel.org with ESMTP id <S131259AbQLXWXD>;
	Sun, 24 Dec 2000 17:23:03 -0500
To: dag@brattli.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] support for FDC37N769 IRDA chip
Message-ID: <977694755.3a467023896d4@imp.free.fr>
Date: Sun, 24 Dec 2000 22:52:35 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
In-Reply-To: <977694274.3a466e42ddfa9@imp.free.fr>
In-Reply-To: <977694274.3a466e42ddfa9@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.40.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grrrr !
For Christmas, I'd like to get a new mailer which doesn't eat my patches :-)
here it is again, after cut'n'paste. Please apply by hand or "patch -l".

Cheers,
Willy

--- linux-2.2.18/drivers/net/irda/smc-ircc.c    Sat Jun 24 14:57:49 2000
+++ linux/drivers/net/irda/smc-ircc.c   Sun Dec 24 21:30:17 2000
@@ -98,6 +98,7 @@
 static smc_chip_t chips[] =
 {
        { "FDC37C669", 0x55, 0x55, 0x0d, 0x04, ircc_probe_69 },
+       { "FDC37N769", 0x55, 0x55, 0x0d, 0x28, ircc_probe_69 },
        { "FDC37N869", 0x55, 0x00, 0x0d, 0x29, ircc_probe_69 },
        { "FDC37N958", 0x55, 0x55, 0x20, 0x09, ircc_probe_58 },
        { NULL }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
