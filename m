Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRJ3VeF>; Tue, 30 Oct 2001 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRJ3Vd5>; Tue, 30 Oct 2001 16:33:57 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:12810 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S276364AbRJ3Vdr>;
	Tue, 30 Oct 2001 16:33:47 -0500
Date: Tue, 30 Oct 2001 21:34:18 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: oops on 2.4.13-pre5 in prune_dcache
Message-ID: <Pine.LNX.4.32.0110302132020.14320-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got this and I'm a few kernels out .. but I thought I'd throw this
way in case it hasn't popped up or been fixed..

I was compiling mopd on a AMD K6-400, 64MB RAM and it oops on the first
gcc.. machine was doing nothing much, no X, 3 sshs to a remote machine...

Mandrake 8.0.

Dave.

ksymoops 2.3.7 on i586 2.4.13-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-pre5/ (default)
     -m /boot/System.map-2.4.13-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol sb_be_quiet  , sb_lib says c4899904, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sb_lib.o says c4897fa4.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol smw_free  , sb_lib says c4899910, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sb_lib.o says c4897fb0.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol audio_devs  , sound says c488bc40, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b5e0.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol midi_devs  , sound says c488bcb0, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b650.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol mixer_devs  , sound says c488bc58, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b5f8.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_audiodevs  , sound says c488bc54, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b5f4.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_midis  , sound says c488bcc8, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b668.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_mixers  , sound says c488bc6c, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b60c.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_synths  , sound says c488bcac, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b64c.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol synth_devs  , sound says c488bc80, /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o says c488b620.  Ignoring /lib/modules/2.4.13-pre5/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c486a470, /lib/modules/2.4.13-pre5/kernel/fs/lockd/lockd.o says c48698dc.  Ignoring /lib/modules/2.4.13-pre5/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c485d24c, /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o says c485cf4c.  Ignoring /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c485d250, /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o says c485cf50.  Ignoring /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c485d254, /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o says c485cf54.  Ignoring /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c485d248, /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o says c485cf48.  Ignoring /lib/modules/2.4.13-pre5/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c484dc48, /lib/modules/2.4.13-pre5/kernel/net/packet/af_packet.o says c484da24.  Ignoring /lib/modules/2.4.13-pre5/kernel/net/packet/af_packet.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000054
c013e227
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013e227>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000040   ebx: c23ded38   ecx: c23da670   edx: c23da670
esi: c23ded20   edi: c23da660   ebp: 0000013b   esp: c1173f5c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1173000)
Stack: 00000019 000003d0 00000006 00000380 c013e4fb 00000662 c0128857 00000006
       000003d0 00000006 00000020 00000000 000003d0 00002a06 c012888d c01dc55c
       00000001 c01dc548 c1172000 c012894d c01dc4a0 00000000 c1173fe0 0008e000
Call Trace: [<c013e4fb>] [<c0128857>] [<c012888d>] [<c012894d>] [<c01289be>]
   [<c0128ae7>] [<c0105000>] [<c01054bb>]
Code: 8b 40 14 85 c0 74 09 57 56 ff d0 83 c4 08 eb 09 57 e8 43 1e

>>EIP; c013e227 <prune_dcache+ab/12c>   <=====
Trace; c013e4fb <shrink_dcache_memory+1b/34>
Trace; c0128857 <shrink_caches+6f/88>
Trace; c012888d <try_to_free_pages+1d/4c>
Trace; c012894d <kswapd_balance_pgdat+55/b0>
Trace; c01289be <kswapd_balance+16/3c>
Trace; c0128ae7 <kswapd+a3/cc>
Trace; c0105000 <_stext+0/0>
Trace; c01054bb <kernel_thread+23/30>
Code;  c013e227 <prune_dcache+ab/12c>
00000000 <_EIP>:
Code;  c013e227 <prune_dcache+ab/12c>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c013e22a <prune_dcache+ae/12c>
   3:   85 c0                     test   %eax,%eax
Code;  c013e22c <prune_dcache+b0/12c>
   5:   74 09                     je     10 <_EIP+0x10> c013e237 <prune_dcache+bb/12c>
Code;  c013e22e <prune_dcache+b2/12c>
   7:   57                        push   %edi
Code;  c013e22f <prune_dcache+b3/12c>
   8:   56                        push   %esi
Code;  c013e230 <prune_dcache+b4/12c>
   9:   ff d0                     call   *%eax
Code;  c013e232 <prune_dcache+b6/12c>
   b:   83 c4 08                  add    $0x8,%esp
Code;  c013e235 <prune_dcache+b9/12c>
   e:   eb 09                     jmp    19 <_EIP+0x19> c013e240 <prune_dcache+c4/12c>
Code;  c013e237 <prune_dcache+bb/12c>
  10:   57                        push   %edi
Code;  c013e238 <prune_dcache+bc/12c>
  11:   e8 43 1e 00 00            call   1e59 <_EIP+0x1e59> c0140080 <iput+0/178>


17 warnings issued.  Results may not be reliable.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


