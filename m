Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRDTUOT>; Fri, 20 Apr 2001 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRDTUOK>; Fri, 20 Apr 2001 16:14:10 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:36111 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129143AbRDTUN5>; Fri, 20 Apr 2001 16:13:57 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 22:13:35 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="unknown-8bit";
  boundary="------------Boundary-00=_NIX3FXH8SL4ZTH6B15N6"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042017575400.01716@antares> <20010420184505.F32759@se1.cogenit.fr>
In-Reply-To: <20010420184505.F32759@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01042022133501.02004@antares>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_NIX3FXH8SL4ZTH6B15N6
Content-Type: text/plain;
  charset="unknown-8bit"
Content-Transfer-Encoding: quoted-printable

On Friday 20 April 2001 18:45, Francois Romieu wrote:
> I assume nothing is overclocked or whatever
Nothing is overclocked.

> Could you try this patch (more output during the loop):
Tried it. The (lengthy) log is attached.
The interrupt is triggered when the other side initiates a request. =20
eth0 is connected to one another computer by a cross-wired cable,
just in case this makes any difference.

Cheers,
Stefan=20

--=20
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
=00
--------------Boundary-00=_NIX3FXH8SL4ZTH6B15N6
Content-Type: text/plain;
  name="epic-log"
Content-Transfer-Encoding: 8bit
Content-Description: log of epic100
Content-Disposition: attachment; filename="epic-log"

Apr 20 21:58:07 antares kernel: epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
Apr 20 21:58:07 antares kernel:   http://www.scyld.com/network/epic100.html
Apr 20 21:58:07 antares kernel:  (unofficial 2.4.x kernel port, version 1.1.6, January 11, 2001)
Apr 20 21:58:07 antares kernel: epic100(00:08.0): EEPROM contents
Apr 20 21:58:07 antares kernel:  e000 2829 ec39 aa00 001d 1c08 10b8 a011 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 21:58:07 antares kernel:  0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 21:58:07 antares kernel:  0010 0000 1980 2100 0000 0000 0003 0000 0701 0000 0000 0000 4d53 3943 3334 5432
Apr 20 21:58:07 antares kernel:  2058 2020 0000 0000 0280 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
Apr 20 21:58:07 antares kernel: epic100(00:08.0): MII transceiver #3 control 3000 status 7809.
Apr 20 21:58:07 antares kernel: epic100(00:08.0): Autonegotiation advertising 01e1 link partner 0001.
Apr 20 21:58:07 antares kernel: eth0: SMSC EPIC/100 83c170 at 0xd800, IRQ 9, 00:e0:29:28:39:ec.
Apr 20 21:58:24 antares kernel: eth0: Setting half-duplex based on MII xcvr 3 register read of 0001.
Apr 20 21:58:24 antares kernel: eth0: epic_open() ioaddr d800 IRQ 9 status 0512 half-duplex.
Apr 20 21:58:27 antares kernel: eth0: Media monitor tick, Tx status 00000003.
Apr 20 21:58:27 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:27 antares kernel: eth0: Setting full-duplex based on MII #3 link partner capability of 41e1.
Apr 20 21:58:32 antares kernel: eth0: Media monitor tick, Tx status 00000003.
Apr 20 21:58:32 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:37 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:58:37 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:42 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:58:42 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:47 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:58:47 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:52 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:58:52 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x00250001 new intstat=0x00240000.
Apr 20 21:58:57 antares kernel:  In epic_rx(), entry 0 00601021.
Apr 20 21:58:57 antares kernel:   epic_rx() status was 00601021.
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x00240000 new intstat=0x00240000.
Apr 20 21:58:57 antares kernel: eth0: exiting interrupt, intr_status=0x240000.
Apr 20 21:58:57 antares kernel: eth0: Media monitor tick, Tx status 00244003.
Apr 20 21:58:57 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 240000 RxStatus 600021.
Apr 20 21:58:57 antares kernel: 6>eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Interrupt, status=0x008d0004 new intstat=0x008c0000.
Apr 20 21:58:57 antares kernel: eth0: desc 00 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 01 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 02 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 03 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 04 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 05 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 06 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 07 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 08 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 09 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 10 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 11 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 12 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 13 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 14 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 15 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 16 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 17 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 18 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 19 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 20 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 21 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 22 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 23 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 24 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 25 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 26 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 27 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 28 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 29 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 30 owned by card
Apr 20 21:58:57 antares kernel: eth0: desc 31 owned by card
Apr 20 21:58:57 antares kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.
Apr 20 21:58:57 antares kernel: eth0: exiting interrupt, intr_status=0x8d0004.
Apr 20 21:59:00 antares /USR/SBIN/CRON[6048]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hourly) 
Apr 20 21:59:02 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:02 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:07 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:07 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:12 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:12 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:17 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:17 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:22 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:22 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:27 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:27 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:32 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:32 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:37 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:37 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:42 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:42 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:47 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:47 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:52 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:52 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 21:59:57 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 21:59:57 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 22:00:00 antares /USR/SBIN/CRON[6058]: (root) CMD ( /usr/lib/sa/sa1      ) 
Apr 20 22:00:02 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 22:00:02 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 22:00:07 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 22:00:07 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.
Apr 20 22:00:12 antares kernel: eth0: Media monitor tick, Tx status 00004003.
Apr 20 22:00:12 antares kernel: eth0: Other registers are IntMask 13bf IntStatus 8c0000 RxStatus 6014a1.

--------------Boundary-00=_NIX3FXH8SL4ZTH6B15N6--
