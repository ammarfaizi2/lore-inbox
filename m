Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRKOKWl>; Thu, 15 Nov 2001 05:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKOKWc>; Thu, 15 Nov 2001 05:22:32 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:63624 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S273588AbRKOKWT>; Thu, 15 Nov 2001 05:22:19 -0500
Date: Thu, 15 Nov 2001 11:22:14 +0100
From: Sven.Riedel@tu-clausthal.de
To: nakai <nakai@neo.shinko.co.jp>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
Message-ID: <20011115112214.A10796@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de> <3BF32B36.8B1375D0@neo.shinko.co.jp> <20011115042843.A383@moog.heim1.tu-clausthal.de> <3BF376BC.B184E954@neo.shinko.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF376BC.B184E954@neo.shinko.co.jp>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 05:03:08PM +0900, nakai wrote:
> > If more machine info is needed, I'd be glad to provide it.
> Do you have any cards on PCI bus ?

Yes. The following is my /proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
3).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0x9000 [0x900f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 15.
      Master Capable.  Latency=32.  
      I/O at 0x9400 [0x941f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
64).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 80).
      IRQ 12.
      I/O at 0x9c00 [0x9cff].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa403].
  Bus  0, device   9, function  0:
    Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10
MBit (rev 49).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda0000ff].
  Bus  0, device  11, function  0:
    SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 16).
      IRQ 15.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=40.
      I/O at 0xac00 [0xac7f].
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
(rev 0).
      IRQ 15.
      I/O at 0xb000 [0xb01f].
  Bus  0, device  14, function  0:
    Unknown mass storage controller: Triones Technologies, Inc. HPT366 /
HPT370 (rev 4).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xb400 [0xb407].
      I/O at 0xb800 [0xb803].
      I/O at 0xbc00 [0xbc07].
      I/O at 0xc000 [0xc003].
      I/O at 0xc400 [0xc4ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
4).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6003fff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd77fffff].

Regs,
Sven

-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
