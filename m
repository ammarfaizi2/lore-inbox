Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274979AbRIZKBQ>; Wed, 26 Sep 2001 06:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275129AbRIZKBH>; Wed, 26 Sep 2001 06:01:07 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:30735 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274979AbRIZKA4> convert rfc822-to-8bit; Wed, 26 Sep 2001 06:00:56 -0400
Date: Wed, 26 Sep 2001 12:00:44 +0200
From: Moritz Moeller-Herrmann <mmh@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: oopses: i386 linux-2.4.10,  es1371 sound card, analog joystick
Message-ID: <20010926120042.A1145@rosalind.local>
Reply-To: Moritz Moeller-Herrmann <mmh@gmx.net>
In-Reply-To: <20010926014233.A1010@rosalind.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20010926014233.A1010@rosalind.local>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 01:42:44AM +0200, Moritz Moeller-Herrmann wrote:

Another longer oops caused by just starting sound:

ksymoops 2.4.1 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /boot/System.map-2.4.10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d0a39460, /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o says d0a39320.  Ignoring /lib/modules/2.4.10/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says d0a2ff00, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2dd20.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol icmpv6_statistics  , ipv6 says d0a2fe00, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2dc20.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count  , ipv6 says d0a2f960, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2d780.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count  , ipv6 says d0a2f964, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2d784.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  , ipv6 says d0a2fd80, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2dba0.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6 says d0a2f900, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2d720.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  , ipv6 says d0a2fc00, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2da20.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics  , ipv6 says d0a2fb00, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2d920.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  , ipv6 says d0a2fd00, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2db20.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6 says d0a2fac8, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2d8e8.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  , ipv6 says d0a2fc80, /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o says d0a2daa0.  Ignoring /lib/modules/2.4.10/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d09ec654, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says d09eaeac.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d09ec680, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says d09eaed8.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d09ec67c, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says d09eaed4.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d09ec684, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says d09eaedc.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d09ec650, /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o says d09eaea8.  Ignoring /lib/modules/2.4.10/kernel/drivers/scsi/scsi_mod.o entry
cpu: 0, clocks: 2004585, slice: 1002292
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
CPU:    0
EIP:    0010:[<d09d4362>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: ffff58f0   ebx: 000000ff   ecx: 00000246   edx: ffffffff
esi: ce158c40   edi: c3dd5000   ebp: ce158c40   esp: c36b9e5c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1077, stackpage=c36b9000)
Stack: ce158c40 ce158c40 c3dd588c c36b9eec ce158800 d09d45c6 ce158c40 d09d4bd4 
       c3dd5000 d09d4bd4 ce158c40 ce158800 c36b9eec c3dd5000 c0000000 d09d119b 
       ce158c40 d09d4bd4 ce158c40 c0000000 d09d1200 ce158c40 ce158c40 00000068 
Call Trace: [<d09d45c6>] [<d09d4bd4>] [<d09d4bd4>] [<d09d119b>] [<d09d4bd4>] 
   [<d09d1200>] [<d33af9cd>] [<d33b09a8>] [<d33b0a20>] [<c01a3fe5>] [<d33b09a8>] 
   [<d33b0a20>] [<c01a4044>] [<d33b0a20>] [<d33afba8>] [<d33b0a20>] [<c011693d>] 
   [<d33aa060>] [<c0106c6b>] 
Code: f7 bf 58 08 00 00 be 00 e0 ff ff 21 e6 89 c1 ba d3 4d 62 10 

>>EIP; d09d4362 <[analog]analog_init_port+c2/2e0>   <=====
Trace; d09d45c6 <[analog]analog_connect+46/e0>
Trace; d09d4bd4 <[analog]analog_dev+0/f>
Trace; d09d4bd4 <[analog]analog_dev+0/f>
Trace; d09d119b <[gameport]gameport_find_dev+1b/30>
Trace; d09d4bd4 <[analog]analog_dev+0/f>
Trace; d09d1200 <[gameport]gameport_register_port+30/40>
Trace; d33af9cd <[es1371]es1371_probe+74d/830>
Trace; d33b09a8 <[es1371]id_table+0/70>
Trace; d33b0a20 <[es1371]es1371_driver+0/3f>
Trace; c01a3fe5 <pci_announce_device+35/50>
Trace; d33b09a8 <[es1371]id_table+0/70>
Trace; d33b0a20 <[es1371]es1371_driver+0/3f>
Trace; c01a4044 <pci_register_driver+44/60>
Trace; d33b0a20 <[es1371]es1371_driver+0/3f>
Trace; d33afba8 <[es1371]init_es1371+28/50>
Trace; d33b0a20 <[es1371]es1371_driver+0/3f>
Trace; c011693d <sys_init_module+50d/5b0>
Trace; d33aa060 <[es1371]wait_src_ready+0/3c>
Trace; c0106c6b <system_call+33/38>
Code;  d09d4362 <[analog]analog_init_port+c2/2e0>
00000000 <_EIP>:
Code;  d09d4362 <[analog]analog_init_port+c2/2e0>   <=====
   0:   f7 bf 58 08 00 00         idiv   0x858(%edi),%eax   <=====
Code;  d09d4368 <[analog]analog_init_port+c8/2e0>
   6:   be 00 e0 ff ff            mov    $0xffffe000,%esi
Code;  d09d436d <[analog]analog_init_port+cd/2e0>
   b:   21 e6                     and    %esp,%esi
Code;  d09d436f <[analog]analog_init_port+cf/2e0>
   d:   89 c1                     mov    %eax,%ecx
Code;  d09d4371 <[analog]analog_init_port+d1/2e0>
   f:   ba d3 4d 62 10            mov    $0x10624dd3,%edx


18 warnings issued.  Results may not be reliable.
-- 
Moritz Moeller-Herrmann mmh@gmx.net ICQ# 3585990
wiss. Mitarbeiter, IMGB
Linus Torvalds: "I'm a big fan of konqueror, and I use it for everything."
