Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPBcI>; Fri, 15 Dec 2000 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLPBb6>; Fri, 15 Dec 2000 20:31:58 -0500
Received: from discus.nl.uu.net ([193.67.79.178]:49630 "EHLO discus.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129228AbQLPBbv>;
	Fri, 15 Dec 2000 20:31:51 -0500
Message-ID: <000701c066fb$aab18900$1500a8c0@infernix>
From: "infernix" <infernix@infernix.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Unable to boot 2.4.0-test12 (0224 AX:0212 BX:BC00 CX:5101 DX:000.)
Date: Sat, 16 Dec 2000 02:01:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After compiling 2.4.0-test12 on my (P2-266, 440LX) Debian 2.2 system (make
bzdisk), i am unable to boot the kernel. When I boot up with the floppy
disk, I do get the Loading...... screen (I think it does load completely),
but afterwards I get this error:

0224
AX:0212
BX:BC00
CX:5101
DX:000.

This error keeps repeating itself. It seems that it keeps reading the boot
floppy every time it prints the error, because the floppy drive light is on,
and when I remove the floppy the error prints faster. At first I thought the
diskette was to blame. However, testing several different diskettes,
including ones I boot earlier 2.2.x kernels on, the problem kept occurring.
The BX and CX values differed though (BX:7400 and CX:5001).

Then, I thought it was ACPI. So I compiled without ACPI, but that didn't
help eiter. I couldn't find any useful info on the list, nor on any search
engine (+kernel +boot +"0224").

Does anyone have any ideas?

Thanks in advance.


Regards,

infernix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
