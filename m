Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFZBEr>; Tue, 25 Jun 2002 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFZBEq>; Tue, 25 Jun 2002 21:04:46 -0400
Received: from host213-123-51-167.in-addr.btopenworld.com ([213.123.51.167]:34696
	"EHLO mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S316210AbSFZBEp>; Tue, 25 Jun 2002 21:04:45 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200206260104.CAA00651@mauve.demon.co.uk>
Subject: 2.4.18 oops.
To: linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2002 02:04:24 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is an oops that occurred for no immediately apparant (to me)
reason.
The CPU was not too warm, overclocked, ...
Athlon 550, 196Mb RAM.
I was probably running very low on memory at this point.
I was not paying attention, so can't vouch for the order in which
these happened.
the last command I remember issuing was lspci -n, as I wanted to find
out the revision of the bt848 in my hauppage card, to try to work out
what might be causing it to flicker a bit.
A large process wanting memory seems to have been killed around this time,
as I had forgotten to activate my secondary swap partition.
I had within the last few seconds switched out of x to run lspci.

I did not unload any modules after the oops, before running ksymoops.

ksymoops 2.4.3 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol __module_author  , tvaudio says cc973460, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc9720a0.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_description  , tvaudio says cc973400, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972040.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , tvaudio says cc9733e8, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972028.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_pic16c54  , tvaudio says cc973550, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972190.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda8425  , tvaudio says cc9734d6, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972116.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9840  , tvaudio says cc9734e6, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972126.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9850  , tvaudio says cc9734f4, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972134.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9855  , tvaudio says cc973504, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972144.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9873  , tvaudio says cc973512, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972152.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9874a  , tvaudio says cc973522, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972162.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9874a_SIF  , tvaudio says cc9734ae, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc9720ee.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tda9874a_STD  , tvaudio says cc9734c2, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972102.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tea6300  , tvaudio says cc973532, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972172.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tea6420  , tvaudio says cc973540, /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o says cc972180.  Ignoring /lib/modules/2.4.18/kernel/drivers/media/video/tvaudio.o entry
Warning (compare_maps): mismatch on symbol __module_description  , sb says cc938520, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938040.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_acer  , sb says cc9385b2, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9380d2.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_acer  , sb says cc9387a0, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9382c0.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_dma  , sb says cc938640, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938160.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_dma16  , sb says cc938680, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9381a0.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_esstype  , sb says cc938780, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9382a0.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_io  , sb says cc9385c0, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9380e0.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_irq  , sb says cc938604, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938124.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_mpu_io  , sb says cc9386c0, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9381e0.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_sm_games  , sb says cc938740, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938260.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_type  , sb says cc938700, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938220.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_dma  , sb says cc938560, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938080.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_dma16  , sb says cc93856c, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc93808c.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_esstype  , sb says cc9385a2, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9380c2.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_io  , sb says cc93854c, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc93806c.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , sb says cc938556, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938076.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_mpu_io  , sb says cc938578, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc938098.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_sm_games  , sb says cc938592, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9380b2.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_type  , sb says cc938586, /lib/modules/2.4.18/kernel/drivers/sound/sb.o says cc9380a6.  Ignoring /lib/modules/2.4.18/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_author  , isdn_lzscomp says cc90bc60, /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o says cc907040.  Ignoring /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o entry
Warning (compare_maps): mismatch on symbol __module_description  , isdn_lzscomp says cc90bc80, /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o says cc907060.  Ignoring /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o entry
Warning (compare_maps): mismatch on symbol __module_parm_comp  , isdn_lzscomp says cc90bcba, /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o says cc90709a.  Ignoring /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , isdn_lzscomp says cc90bcac, /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o says cc90708c.  Ignoring /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o entry
Warning (compare_maps): mismatch on symbol __module_parm_tweak  , isdn_lzscomp says cc90bcc6, /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o says cc9070a6.  Ignoring /lib/modules/2.4.18/kernel/drivers/isdn/isdn_lzscomp.o entry
Warning (compare_maps): mismatch on symbol __module_parm_xa_test  , sr_mod says cc86aa48, /lib/modules/2.4.18/kernel/drivers/scsi/sr_mod.o says cc868028.  Ignoring /lib/modules/2.4.18/kernel/drivers/scsi/sr_mod.o entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129ce8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c1210c5c   ebx: c1016800   ecx: c1016800   edx: c96c35f0
esi: c1016800   edi: 00000000   ebp: 00000200   esp: c133df18
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c133d000)
Stack: c18f6140 c1016800 00000005 00000200 c1016800 000001d0 c18f6140 c1016800
       c01295f2 c012a3db c012962b 00000020 000001d0 00000020 00000006 00000006
       c133c000 0000145e 000001d0 c01f5ac8 c0129836 00000006 00000006 00000006
Call Trace: [<c01295f2>] [<c012a3db>] [<c012962b>] [<c0129836>] [<c012989c>]
   [<c0129933>] [<c0129996>] [<c0129aad>] [<c010586f>] [<c0105878>]
Code: 0f 0b 89 d8 2b 05 4c 1c 24 c0 c1 f8 06 3b 05 40 1c 24 c0 72

>>EIP; c0129ce8 <__free_pages_ok+28/200>   <=====
Trace; c01295f2 <shrink_cache+1d2/2f0>
Trace; c012a3da <__free_pages+1a/20>
Trace; c012962a <shrink_cache+20a/2f0>
Trace; c0129836 <shrink_caches+56/80>
Trace; c012989c <try_to_free_pages+3c/60>
Trace; c0129932 <kswapd_balance_pgdat+42/90>
Trace; c0129996 <kswapd_balance+16/30>
Trace; c0129aac <kswapd+9c/c0>
Trace; c010586e <kernel_thread+1e/40>
Trace; c0105878 <kernel_thread+28/40>
Code;  c0129ce8 <__free_pages_ok+28/200>
00000000 <_EIP>:
Code;  c0129ce8 <__free_pages_ok+28/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129cea <__free_pages_ok+2a/200>
   2:   89 d8                     mov    %ebx,%eax
Code;  c0129cec <__free_pages_ok+2c/200>
   4:   2b 05 4c 1c 24 c0         sub    0xc0241c4c,%eax
Code;  c0129cf2 <__free_pages_ok+32/200>
   a:   c1 f8 06                  sar    $0x6,%eax
Code;  c0129cf4 <__free_pages_ok+34/200>
   d:   3b 05 40 1c 24 c0         cmp    0xc0241c40,%eax
Code;  c0129cfa <__free_pages_ok+3a/200>
  13:   72 00                     jb     15 <_EIP+0x15> c0129cfc <__free_pages_ok+3c/200>


40 warnings issued.  Results may not be reliable.
