Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273598AbRIQMd0>; Mon, 17 Sep 2001 08:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273596AbRIQMdR>; Mon, 17 Sep 2001 08:33:17 -0400
Received: from koala.ichpw.zabrze.pl ([195.82.164.33]:40196 "EHLO
	koala.ichpw.zabrze.pl") by vger.kernel.org with ESMTP
	id <S273588AbRIQMdK>; Mon, 17 Sep 2001 08:33:10 -0400
Message-Id: <200109171244.f8HCiTZ00707@koala.ichpw.zabrze.pl>
From: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 17 Sep 2001 14:33:19 -0400 (EDT)
Reply-To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
X-Mailer: (Demonstration) PMMail 2.00.1500 for OS/2 Warp 3.00
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Subject: PCI - Tseng ET6000 - bad memory amount  detection 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking  for lscpci  output  I have found that amount of detected
memory on my  SVGA Tseng ET6000 is incorrect :

00:0f.0 VGA compatible controller: Tseng Labs Inc ET6000 (rev 30)
(prog-if 00 [V
GA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow
>TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e5000000 (32-bit,
non-prefetchable)[size=16M]
        Region 1: I/O ports at e800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=16M]

The card has only 2 M  - and this incorrect detection  makes 
problems in use mtrr under  XFree4.x .


 Is it   hardware problem    or error  in PCI detection routines ?
     

--------------------------------------------------------
 Marek Mentel  mmark@koala.ichpw.zabrze.pl  2:484/3.8          
 INSTITUTE FOR CHEMICAL PROCESSING OF COAL , Zabrze , POLAND
 NOTE: my opinions are strictly my own and not those of my employer



