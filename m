Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbRBAA2d>; Wed, 31 Jan 2001 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129815AbRBAA2X>; Wed, 31 Jan 2001 19:28:23 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:16904 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129851AbRBAA2I>; Wed, 31 Jan 2001 19:28:08 -0500
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Netzwerkadministrator WH8/DD
To: linux-kernel@vger.kernel.org
Subject: Problems compiling hdparm with string.h (2.4.x)
Date: Thu, 1 Feb 2001 01:28:07 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Message-Id: <01020101280700.16535@backfire>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just tried to compile hdparm v3.9 with a vanilla 2.4.1 tree.
Gcc complained about serveral parse errors in /usr/include/linux/string.h.
Compiling with an >=ac6 release works fine.
Why isn't the little string.h fix not included in 2.4.1?

Regards, Gregor

PS: Is this normal: (ac-12, 1xPIII, iBX , IO-, UP- and LOCAL-APIC=y)
/proc/interrupts
           CPU0
  0:    9997185          XT-PIC  timer
  1:      51952          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:     482976          XT-PIC  parport0
  9:    8270642          XT-PIC  eth0, EMU10K1
 10:     932284          XT-PIC  bttv
 12:     930300          XT-PIC  PS/2 Mouse
 14:      77025          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:    9995269
LOC:    9996969
ERR:          0
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
