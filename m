Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135672AbRD2Coa>; Sat, 28 Apr 2001 22:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135673AbRD2CoW>; Sat, 28 Apr 2001 22:44:22 -0400
Received: from mail2.rdc2.on.home.com ([24.9.0.41]:60371 "EHLO
	mail2.rdc2.on.home.com") by vger.kernel.org with ESMTP
	id <S135672AbRD2CoI>; Sat, 28 Apr 2001 22:44:08 -0400
Message-ID: <002f01c0d056$3c89c2c0$0f00a8c0@mydomain.org>
From: "Jeff Muizelaar" <muizelaar@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: ASIX AX88140 doesn't work under 2.4.x kernel
Date: Sat, 28 Apr 2001 22:43:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having dificulty getting an ASIX AX88140 ethernet card to work under
the 2.4.3 kernel.
    It works perfectly under a 2.2.19 kernel and is found properly, but when
trying the 2.4.3 kernel it fails with the message:

    tulip: eth1: MMIO region (0x0@0x0) unavailable, aborting

tulip-diag still detects the card, here is the results of it under 2.4.3:

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Macronix 98715 PMAC adapter at 0xbc00.
 Port selection is 10mpbs-serial 100baseTx scrambler, full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit unit is set to store-and-forward.
Index #2: Found a ASIX AX88140 adapter at 0xc000.
 Port selection is MII, half-duplex.
 Transmit stopped, Receive stopped, half-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 128.
 The MAC/filter registers are  18cac000 00007f8a 80000000 00000000.
 Use '-a' or '-aa' to show device registers,
     '-e' to show EEPROM contents, -ee for parsed contents,
  or '-m' or '-mm' to show MII management registers.


