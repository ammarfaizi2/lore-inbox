Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281308AbRKEUIu>; Mon, 5 Nov 2001 15:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281307AbRKEUId>; Mon, 5 Nov 2001 15:08:33 -0500
Received: from out2.mx.nwbl.wi.voyager.net ([169.207.2.79]:28940 "EHLO
	out2.mx.nwbl.wi.voyager.net") by vger.kernel.org with ESMTP
	id <S281306AbRKEUI2>; Mon, 5 Nov 2001 15:08:28 -0500
Message-Id: <200111052008.fA5K8OQ45166@pop2.nwbl.wi.voyager.net>
Date: Tue, 6 Nov 2001 07:08:26 +1100
From: "a. p. garcia" <apgarcia@uwm.edu>
To: linux-kernel@vger.kernel.org
Subject: upchuckin' 2.2.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 00000023
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<cfff893b>]
EFLAGS: 00010002
eax: cfff8883   ebx: 00000bb3   ecx: 4539201f   edx: 00000023
esi: c009e800   edi: ffffffff   ebp: cfff8ae0   esp: c0207e03
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c0207000)
Stack: 000023c0 ff8ae000 1b165ecf 000000c0 00028600 09e80000 207ef0c0 1bdfb8c0
       000000c0 ff8ac000 000000cf 1b168200 000000c0 00002300 1c175400 09e800c0
       000000c0 00028600 00028600 ff926000 000001cf 00000a04 ff88e000 000000cf
Call Trace: Bad ESP value.
Code: 00 0a 00 00 00 00 e0 00 00 07 00 00 00 20 01 00 00 20 00 7f
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing


-----
WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops
Options used: -V (default)
              -o /lib/modules/2.2.20/ (default)
              -k proc.ksys (specified)
              -l /proc/modules (default)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

Warning, no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning: pcxx symbol __insmod_pcxx_O/lib/modules/2.2.20/misc/pcxx.o_M3BE5DF45_V131604 not found in /lib/modules/2.2.20/misc/pcxx.o.  Ignoring /lib/modules/2.2.20/misc/pcxx.o entry
Warning: pcxx symbol __insmod_pcxx_S.bss_L412 not found in /lib/modules/2.2.20/misc/pcxx.o.  Ignoring /lib/modules/2.2.20/misc/pcxx.o entry
Warning: pcxx symbol __insmod_pcxx_S.data_L8412 not found in /lib/modules/2.2.20/misc/pcxx.o.  Ignoring /lib/modules/2.2.20/misc/pcxx.o entry
Warning: pcxx symbol __insmod_pcxx_S.rodata_L2687 not found in /lib/modules/2.2.20/misc/pcxx.o.  Ignoring /lib/modules/2.2.20/misc/pcxx.o entry
Warning: pcxx symbol __insmod_pcxx_S.text_L15596 not found in /lib/modules/2.2.20/misc/pcxx.o.  Ignoring /lib/modules/2.2.20/misc/pcxx.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000023
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<cfff893b>]
EFLAGS: 00010002
eax: cfff8883   ebx: 00000bb3   ecx: 4539201f   edx: 00000023
esi: c009e800   edi: ffffffff   ebp: cfff8ae0   esp: c0207e03
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c0207000)
Stack: 000023c0 ff8ae000 1b165ecf 000000c0 00028600 09e80000 207ef0c0 1bdfb8c0
       000000c0 ff8ac000 000000cf 1b168200 000000c0 00002300 1c175400 09e800c0
       000000c0 00028600 00028600 ff926000 000001cf 00000a04 ff88e000 000000cf
Call Trace: Bad ESP value.
Code: 00 0a 00 00 00 00 e0 00 00 07 00 00 00 20 01 00 00 20 00 7f

>>EIP: cfff893b <_end+fdc0e13/105cc52c>
Code:  cfff893b <_end+fdc0e13/105cc52c>        00000000 <_EIP>: <===
Code:  cfff893b <_end+fdc0e13/105cc52c>           0:	00 0a                	add    %cl,(%edx) <===
Code:  cfff893d <_end+fdc0e15/105cc52c>           2:	00 00                	add    %al,(%eax)
Code:  cfff893f <_end+fdc0e17/105cc52c>           4:	00 00                	add    %al,(%eax)
Code:  cfff8941 <_end+fdc0e19/105cc52c>           6:	e0 00                	loopne  cfff8943 <_end+fdc0e1b/105cc52c>
Code:  cfff8943 <_end+fdc0e1b/105cc52c>           8:	00 07                	add    %al,(%edi)
Code:  cfff8945 <_end+fdc0e1d/105cc52c>           a:	00 00                	add    %al,(%eax)
Code:  cfff8947 <_end+fdc0e1f/105cc52c>           c:	00 20                	add    %ah,(%eax)
Code:  cfff8949 <_end+fdc0e21/105cc52c>           e:	01 00                	add    %eax,(%eax)
Code:  cfff894b <_end+fdc0e23/105cc52c>          10:	00 20                	add    %ah,(%eax)
Code:  cfff894d <_end+fdc0e25/105cc52c>          12:	00 7f 00             	add    %bh,0x0(%edi)

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

8 warnings issued.  Results may not be reliable.


-----
when searching for the oops log, i also found the following,
for which i know longer have the ksyms.  sorry if it's useless:

Nov  3 11:40:06 giuseppe kernel: Unable to handle kernel paging request at virtual address c020cc00
Nov  3 11:40:06 giuseppe kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Nov  3 11:40:06 giuseppe kernel: *pde = 000001e3
Nov  3 11:40:06 giuseppe kernel: *pte = 00000000
Nov  3 11:40:06 giuseppe kernel: Oops: 0002
Nov  3 11:40:06 giuseppe kernel: CPU:    0
Nov  3 11:40:06 giuseppe kernel: EIP:    0010:[schedule+267/636]
Nov  3 11:40:06 giuseppe kernel: EFLAGS: 00010002
Nov  3 11:40:06 giuseppe kernel: eax: c020cc00   ebx: c01fa000   ecx: cfff0000   edx: 0000003b
Nov  3 11:40:06 giuseppe kernel: esi: cfff0000   edi: 0000003b   ebp: cfff1ecc   esp: cfff1ebc
Nov  3 11:40:06 giuseppe kernel: ds: 0018   es: 0018   ss: 0018
Nov  3 11:40:06 giuseppe kernel: Process kupdate (pid: 3, process nr: 3, stackpage=cfff1000)
Nov  3 11:40:06 giuseppe kernel: Stack: 00000212 c0170a19 c02244a0 c020cc00 cfff1efc c0170a25 00000000 c0214820 
Nov  3 11:40:06 giuseppe kernel:        00000811 cfff1f5c c0214890 000002a8 cfff0000 08110008 cfff0000 c0223578 
Nov  3 11:40:06 giuseppe kernel:        cfff1f5c c0171654 00000055 00000811 00000010 00000246 00000000 cfff1fc0 
Nov  3 11:40:06 giuseppe kernel: Call Trace: [__get_request_wait+293/376] [__get_request_wait+305/376] [make_request+1808/1932] [ll_rw_block+337/448] [sync_old_buffers+194/440] [tvecs+11147/12832] [process_timeout+0/20] 
Nov  3 11:40:06 giuseppe kernel:        [kupdate+116/120] [kernel_thread+31/56] [kernel_thread+40/56] 
Nov  3 11:40:06 giuseppe kernel: Code: 89 08 fb 39 ce 0f 84 59 01 00 00 ff 05 8c c2 1e c0 89 f3 89 
