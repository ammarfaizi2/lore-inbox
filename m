Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265217AbSIWJNz>; Mon, 23 Sep 2002 05:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSIWJNz>; Mon, 23 Sep 2002 05:13:55 -0400
Received: from stingr.net ([212.193.32.15]:45071 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S265217AbSIWJNy>;
	Mon, 23 Sep 2002 05:13:54 -0400
Date: Mon, 23 Sep 2002 13:18:51 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] Ide 2.4.20-pre7-ac3 oops on vmware - you might be interested
Message-ID: <20020923091851.GF21592@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from my vmware. May be my fault but same kernel works on real
ide hardware (at least on ONE real ide box :) )

----- Forwarded message from stingray@proxy.sgu.ru -----

Delivered-To: i@stingr.net
Date: Mon, 23 Sep 2002 13:16:39 +0400
From: stingray@proxy.sgu.ru
To: i@stingr.net

ksymoops 2.4.1 on i686 2.4.19-pre5-ac3-s45.  Options used
     -v /ex/s/trees/vmwfake/lib/modules/2.4.20-pre7-ac3-s2/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /ex/s/trees/vmwfake/lib/modules/2.4.20-pre7-ac3-s2/ (specified)
     -m /ex/s/trees/vmwfake/boot/System.map-2.4.20-pre7-ac3-s2 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 0000041c
c01e4544
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e4544>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000202
eax: 00000000   ebx: c03bc920   ecx: c15124cc   edx: c032db74
esi: c03bc90c   edi: 000010b8   ebp: 00000008   esp: c1527edc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1527000)
Stack: 00000008 c03bc90c c1512400 c032db74 c01e4606 c03bc90c 000010b8 00000008 
       000010b8 c03bc90c c03726e1 c03bc90c 000010b8 00000008 c01e2e16 c03bc90c 
       000010b8 0005db95 c03bc90c c032db95 c03b01f0 c032db74 c01e3186 c1512400 
Call Trace:    [<c01e4606>] [<c01e2e16>] [<c01e3186>] [<c01e31f7>] [<c01d5d45>]
  [<c0105000>] [<c0105029>] [<c0105000>] [<c0105596>] [<c0105020>]
Code: 8b 80 1c 04 00 00 eb 06 8d 74 26 00 89 f8 89 86 18 04 00 00 

>>EIP; c01e4544 <ide_iomio_dma+a4/110>   <=====
Trace; c01e4606 <ide_setup_dma+16/2a0>
Trace; c01e2e16 <ide_hwif_setup_dma+b6/f0>
Trace; c01e3186 <do_ide_setup_pci_device+236/290>
Trace; c01e31f7 <ide_setup_pci_device+17/20>
Trace; c01d5d45 <piix_init_one+35/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105029 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105596 <kernel_thread+26/30>
Trace; c0105020 <init+0/140>
Code;  c01e4544 <ide_iomio_dma+a4/110>
00000000 <_EIP>:
Code;  c01e4544 <ide_iomio_dma+a4/110>   <=====
   0:   8b 80 1c 04 00 00         mov    0x41c(%eax),%eax   <=====
Code;  c01e454a <ide_iomio_dma+aa/110>
   6:   eb 06                     jmp    e <_EIP+0xe> c01e4552 <ide_iomio_dma+b2/110>
Code;  c01e454c <ide_iomio_dma+ac/110>
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01e4550 <ide_iomio_dma+b0/110>
   c:   89 f8                     mov    %edi,%eax
Code;  c01e4552 <ide_iomio_dma+b2/110>
   e:   89 86 18 04 00 00         mov    %eax,0x418(%esi)

 <0>Kernel panic: Attempted to kill init!

----- End forwarded message -----

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
