Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbSKSWAl>; Tue, 19 Nov 2002 17:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbSKSWAl>; Tue, 19 Nov 2002 17:00:41 -0500
Received: from p0137.as-l043.contactel.cz ([194.108.242.137]:17392 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S267504AbSKSWAk> convert rfc822-to-8bit; Tue, 19 Nov 2002 17:00:40 -0500
To: linux-kernel@vger.kernel.org
Subject: PCI serial card with PCI 9052?
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Tue, 19 Nov 2002 23:09:44 +0100
Message-ID: <m3smxx1aaf.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a PCI card with two serial ports on it. It has PLX Technology
PCI9052 and HOLTEK HT6552IR chips. Pictures of that card are at
http://www.janik.cz/tmp/pci9052/.

lspci:

00:08.0 Network controller: PLX Technology, Inc. PCI <-> IOBus Bridge (rev 02)
	Subsystem: Unknown device d841:0200
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e400b000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at d400 [size=128]
	Region 2: I/O ports at d800 [size=8]
	Region 3: I/O ports at dc00 [size=8]
00: b5 10 50 90 03 00 80 02 02 00 80 02 08 00 00 00
10: 00 b0 00 e4 01 d4 00 00 01 d8 00 00 01 dc 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 41 d8 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

Is this card supported? Tim?
-- 
Pavel Janík

/* After several hours of tedious analysis, the following hash
 * function won.  Do not mess with it... -DaveM
 */
                  -- 2.2.16 fs/buffer.c
