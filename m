Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRCFT4b>; Tue, 6 Mar 2001 14:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRCFT4X>; Tue, 6 Mar 2001 14:56:23 -0500
Received: from pop.gmx.net ([194.221.183.20]:49106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129284AbRCFT4K>;
	Tue, 6 Mar 2001 14:56:10 -0500
Message-ID: <3AA540AD.5BEDF2B0@gmx.de>
Date: Tue, 06 Mar 2001 20:55:25 +0100
From: ernte23@gmx.de
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i586)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I tried the linux 2.4.3-pre2 patch and it crashed like this.
i do not know what this is about, but maybe it helps someone:

----------
kernel BUG at page_alloc.c:75!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+62/840]
EFLAGS: 00010286
eax: 0000001f   ebx: c11f2fb0   ecx: 00000000   edx: ffffffff
esi: c11f2fb0   edi: 00000000   ebp: 00000011   esp: c7f9df60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c7f9d000)
Stack: c01f21e5 c01f2373 0000004b c11f2fd8 c11f2fb0 c0220558 00000011
c0220558 
       00000010 c0fa9680 00000003 c0129e79 c012b6ae c012a075 00010f00
00000000 
       00000004 00000000 00000000 00000000 00000004 00000000 0000007f
c012a6f0 
Call Trace: [page_launder+805/2072] [__free_pages+26/28]
[page_launder+1313/2072] [do_try_to_free_pages+52/124] [kswapd+115/272]
[empty_bad_page+0/4096] [kernel_thread+35/48]
----------

/proc/pci: PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 71).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   8, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xd400 [0xd43f].
  Bus  0, device   9, function  0:
    Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
A1 ISDN [Fritz] (rev 2).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xea001000 [0xea00101f].
      I/O at 0xd800 [0xd81f].
  Bus  0, device  10, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 1).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=30.Max Lat=64.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xea003000 [0xea0030ff].
      Non-prefetchable 32 bit memory at 0xea000000 [0xea000fff].
  Bus  0, device  11, function  0:
    Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev
66).
      IRQ 7.
      Master Capable.  Latency=64.  Min Gnt=3.Max Lat=8.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xea002000 [0xea0020ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev
21).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4ffffff].
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].


thank you,
Felix T.

