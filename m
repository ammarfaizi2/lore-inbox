Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQLXWPR>; Sun, 24 Dec 2000 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbQLXWPH>; Sun, 24 Dec 2000 17:15:07 -0500
Received: from smtp2.free.fr ([212.27.32.6]:35343 "EHLO smtp2.free.fr")
	by vger.kernel.org with ESMTP id <S129825AbQLXWPC>;
	Sun, 24 Dec 2000 17:15:02 -0500
From: wtarreau@free.fr
To: dag@brattli.net
Subject: [patch] support for FDC37N769 IRDA chip
Message-ID: <977694274.3a466e42ddfa9@imp.free.fr>
Date: Sun, 24 Dec 2000 22:44:34 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ9776942741a0da5113cfa203c95a617f8500ce6e3"
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.40.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ9776942741a0da5113cfa203c95a617f8500ce6e3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello Dag,

I discovered that my notebook supported FIR, but I didn't know the chip (and it
was not documented). So I disassembled it completely and found an SMC FDC37N769
inside. It's now correctly detected with the following trivial patch against
kernel 2.2.18 (the same entry should be added to findchip).

Merry Christmas to you and all the folks on LKML,
Willy


---MOQ9776942741a0da5113cfa203c95a617f8500ce6e3
Content-Type: application/octet-stream; name="irda-fdc37n769-2.2.18.diff"; name="irda-fdc37n769-2.2.18.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="irda-fdc37n769-2.2.18.diff"




---MOQ9776942741a0da5113cfa203c95a617f8500ce6e3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
