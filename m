Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129667AbQKWPRG>; Thu, 23 Nov 2000 10:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129749AbQKWPQ5>; Thu, 23 Nov 2000 10:16:57 -0500
Received: from kelland.nwc.alaska.net ([209.112.130.6]:49141 "EHLO alaska.net")
        by vger.kernel.org with ESMTP id <S129667AbQKWPQv>;
        Thu, 23 Nov 2000 10:16:51 -0500
Date: Thu, 23 Nov 2000 05:46:44 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: binary garbage in dmesg/boot messages (2.2.18pre23)
Message-ID: <20001123054644.A23839@plato.local.lan>
Mail-Followup-To: Ethan Benson <erbenson@alaska.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was testing out 2.2.18pre23 for USB purposes and found that its
outputing binary garbage at boot:

BIOS Vendor: Intel Corporation
BIOS Version: 1.00.10.DD04
BIOS Release: 03/19/97
System Vendor: Sony Corporation.
Product Name: PCV-70(U2).
Version Sony GI.
Serial Number 1003494.
Board Vendor: Intel Corporation.
Board Name: Agate.
Board Version: AA662195-305.
BIOS Vendor: f.�^]<94>fA�^D.�ESC<94>^N^_
BIOS Version: SV^^g�u^B.<8B>^^^^<9D><88>^\g�u^F.<8B>^^
<9D><89>^\3A^_^[A^^^FfQfPfRfSfUfVfW<8A>�g�}^B&<8A>^E�h^Dr]g�}^Fg<8B>U
�A��uT<83>�^CtO#OtK^N^_.<8B>7.<8B>O^D�A^A
BIOS Release: ���SQR^F^^WV^^^F^_^G<87>�.<8B>^N�<8B>x^C��C�rW&<8B>]
^C�+E��^^^F^_W��<8B>U<8B>x_&<8B>^O&<8A>^G&<88>^ECG;�s-��^G_W.<8B>^N�<8B>UA�^BfPf<8B>^Af<89>^E<83>�^D�ofX<8B>^V�^U

it appears to not cause any further problems, other then trashing the
terminal of anyone who runs dmesg...

/proc/version:
Linux version 2.2.18pre23 (root@plato) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 Thu Nov 23 04:01:23 AKST 2000

this does not occur under 2.2.17.  

please CC replies.  

-- 
Ethan Benson
http://www.alaska.net/~erbenson/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
