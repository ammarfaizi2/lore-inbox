Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136618AbRAMMPm>; Sat, 13 Jan 2001 07:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136648AbRAMMPc>; Sat, 13 Jan 2001 07:15:32 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:26378 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S136618AbRAMMPQ>; Sat, 13 Jan 2001 07:15:16 -0500
Date: Sat, 13 Jan 2001 13:16:07 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.19pre7 & broken eepro100?
Message-ID: <Pine.LNX.4.30.0101131308570.3318-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Today my important machine has dicsonneted from network with message
like this:

Jan 13 12:24:25 portraits kernel: eth0: can't fill rx buffer (force 0)!
Jan 13 12:24:25 portraits kernel: eth0: can't fill rx buffer (force 1)!
Jan 13 12:24:26 portraits kernel: eth0: can't fill rx buffer (force 0)!
Jan 13 12:24:26 portraits kernel: eth0: can't fill rx buffer (force 1)!

eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:A0:C9:FC:02:70, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15

Machine:

Linux RedHat 7.0, glibc 2.2, 1GB RAM, with running squid,news,uucp,nfs.
2 X Pentium III,

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF
(rev 06)
00:0c.0 SCSI storage controller: Adaptec 7896
00:0c.1 SCSI storage controller: Adaptec 7896
00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 05)



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
