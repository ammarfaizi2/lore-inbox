Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273591AbRIQMbg>; Mon, 17 Sep 2001 08:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRIQMb1>; Mon, 17 Sep 2001 08:31:27 -0400
Received: from koala.ichpw.zabrze.pl ([195.82.164.33]:38148 "EHLO
	koala.ichpw.zabrze.pl") by vger.kernel.org with ESMTP
	id <S273597AbRIQMbN>; Mon, 17 Sep 2001 08:31:13 -0400
Message-Id: <200109171242.f8HCgVZ00681@koala.ichpw.zabrze.pl>
From: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 17 Sep 2001 14:31:21 -0400 (EDT)
Reply-To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
X-Mailer: (Demonstration) PMMail 2.00.1500 for OS/2 Warp 3.00
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_=_=_=IMA.BOUNDARY.GJTKS9138764=_=_=_"
Subject: Athlon bug - Abit KT7E
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_=_=_=IMA.BOUNDARY.GJTKS9138764=_=_=_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Abit KT7E mobo , 256 M noname RAM
Duron 800 cpu 

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 800.045
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr
pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1595.80
 
K7-optimized kernel works ok with bios ZT  , crash with 3R bios.
K7-optimized kernel + patch   boot ok with 3R bios, but    I have
found in log :
( after  20 min of work ) :

Sep 15 13:19:40 bulma kernel: hda: dma_intr: status=0x71 { DriveReady
DeviceFaul
t SeekComplete Error }
Sep 15 13:19:40 bulma kernel: hda: dma_intr: error=0x10 {
SectorIdNotFound }, LB
Asect=9484373, sector=3604580
Sep 15 13:19:40 bulma kernel: hda: DMA disabled
Sep 15 13:19:40 bulma kernel: ide0: reset: success


Output from lspci -vvxxx   for both bios attached .


--------------------------------------------------------
 Marek Mentel  mmark@koala.ichpw.zabrze.pl  2:484/3.8          
 INSTITUTE FOR CHEMICAL PROCESSING OF COAL , Zabrze , POLAND
 NOTE: my opinions are strictly my own and not those of my employer



--_=_=_=IMA.BOUNDARY.GJTKS9138764=_=_=_
Content-Type: application/octet-stream; name="zt_3r.zip"
Content-Transfer-Encoding: base64

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
TE9HX1pUUEsFBgAAAAACAAIAaAAAAPwQAAAAAA==

--_=_=_=IMA.BOUNDARY.GJTKS9138764=_=_=_--
