Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273625AbRIQO36>; Mon, 17 Sep 2001 10:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273626AbRIQO3t>; Mon, 17 Sep 2001 10:29:49 -0400
Received: from [195.66.192.167] ([195.66.192.167]:11025 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273625AbRIQO3j>; Mon, 17 Sep 2001 10:29:39 -0400
Date: Mon, 17 Sep 2001 17:27:59 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <312430534.20010917172759@port.imtp.ilyichevsk.odessa.ua>
To: "Marek Mentel" <mmark@koala.ichpw.zabrze.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon bug - Abit KT7E
In-Reply-To: <200109171242.f8HCgVZ00681@koala.ichpw.zabrze.pl>
In-Reply-To: <200109171242.f8HCgVZ00681@koala.ichpw.zabrze.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,

Glad our patch works for you.
Thanks for lspci -vvvxxx dump.
HDD DMA failure is probably unrelated to Athlon bug.
However, report anything strange you see.

Monday, September 17, 2001, 9:31:21 PM, you wrote:
MM> Abit KT7E mobo , 256 M noname RAM
MM> Duron 800 cpu 

MM> processor       : 0
MM> vendor_id       : AuthenticAMD
MM> cpu family      : 6
MM> model           : 3
MM> model name      : AMD Duron(tm) Processor
MM> stepping        : 1
MM> cpu MHz         : 800.045
MM> cache size      : 64 KB
MM> fdiv_bug        : no
MM> hlt_bug         : no
MM> f00f_bug        : no
MM> coma_bug        : no
MM> fpu             : yes
MM> fpu_exception   : yes
MM> cpuid level     : 1
MM> wp              : yes
MM> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr
MM> pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
MM> bogomips        : 1595.80
 
MM> K7-optimized kernel works ok with bios ZT  , crash with 3R bios.
MM> K7-optimized kernel + patch   boot ok with 3R bios, but    I have
MM> found in log :
MM> (after  20 min of work ):

MM> Sep 15 13:19:40 bulma kernel: hda: dma_intr: status=0x71 { DriveReady
MM> DeviceFaul
MM> t SeekComplete Error }
MM> Sep 15 13:19:40 bulma kernel: hda: dma_intr: error=0x10 {
MM> SectorIdNotFound }, LB
MM> Asect=9484373, sector=3604580
MM> Sep 15 13:19:40 bulma kernel: hda: DMA disabled
MM> Sep 15 13:19:40 bulma kernel: ide0: reset: success
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


