Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292929AbSB0UbZ>; Wed, 27 Feb 2002 15:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292938AbSB0UbD>; Wed, 27 Feb 2002 15:31:03 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:7808
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S292929AbSB0UaI>; Wed, 27 Feb 2002 15:30:08 -0500
Date: Wed, 27 Feb 2002 12:29:54 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
In-Reply-To: <Pine.LNX.4.10.10202271137380.4758-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.33.0202271228470.5225-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 27 Feb 2002, James Simmons wrote:

> Okay folks. Here is another patch to fix the oops. It is against a
> http://www.transvirtual.com/~jsimmons/console/console_8.diff

James, I still get oopses at boot:

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi

ksymoops 2.4.1 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says d093a5e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09382e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol icmpv6_statistics  , ipv6 says d093a4e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09381e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count  , ipv6 says d093a100, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937e00.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count  , ipv6 says d093a104, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937e04.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  , ipv6 says d093a460, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0938160.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6 says d093a080, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937d80.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  , ipv6 says d093a360, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0938060.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics  , ipv6 says d093a2a0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937fa0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw6_sk_cachep  , ipv6 says d093a0e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937de0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  , ipv6 says d093a3e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09380e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6 says d093a268, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937f68.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol tcp6_sk_cachep  , ipv6 says d093a0d8, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937dd8.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp6_sk_cachep  , ipv6 says d093a0dc, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937ddc.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  , ipv6 says d093a3a0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09380a0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says d08e6834, /lib/modules/2.5.5-dj2/kernel/drivers/scsi/sr_mod.o says d08e6560.  Ignoring /lib/modules/2.5.5-dj2/kernel/drivers/scsi/sr_mod.o entry
8139too Fast Ethernet driver 0.9.24
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0188369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0188369>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c1241100   ebx: cc207000   ecx: 00000720   edx: 00000000
esi: 00000050   edi: 00000054   ebp: cf87d234   esp: cbf55ea0
ds: 0018   es: 0018   ss: 0018
Stack: cbee0000 00000001 cbf50402 c0189029 00000001 00000000 00000000 c017f726
       cbee0000 cf87d234 00000002 cbee0000 cfb09c80 cbf55ee8 cbf54000 cbf55f84
       00000001 cfdce009 cfb09c80 00000005 cfafc7ac c13650e4 00000000 00000000
Call Trace: [<c0189029>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00

>>EIP; c0188369 <vc_allocate+d9/f0>   <=====
Trace; c0189029 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c0188369 <vc_allocate+d9/f0>
00000000 <_EIP>:
Code;  c0188369 <vc_allocate+d9/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c018836e <vc_allocate+de/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c0188370 <vc_allocate+e0/f0>
   7:   5b                        pop    %ebx
Code;  c0188371 <vc_allocate+e1/f0>
   8:   5e                        pop    %esi
Code;  c0188372 <vc_allocate+e2/f0>
   9:   5f                        pop    %edi
Code;  c0188373 <vc_allocate+e3/f0>
   a:   c3                        ret
Code;  c0188374 <vc_allocate+e4/f0>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018837a <vc_allocate+ea/f0>
  11:   8d bf 00 00 00 00         lea    0x0(%edi),%edi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0188369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0188369>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc207200   ecx: 00000720   edx: 00000000
esi: 00000050   edi: 00000058   ebp: cfd7ec04   esp: cc033ea0
ds: 0018   es: 0018   ss: 0018
Stack: cc517000 00000002 cc030403 c0189029 00000002 00000000 00000000 c017f726
       cc517000 cfd7ec04 00000002 cc517000 cfb09d88 cc033ee8 cc032000 cc033f84
       00000001 cdd26009 cfb09d88 00000005 cfafca04 c136516c 00000000 00000000
Call Trace: [<c0189029>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00

>>EIP; c0188369 <vc_allocate+d9/f0>   <=====
Trace; c0189029 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c0188369 <vc_allocate+d9/f0>
00000000 <_EIP>:
Code;  c0188369 <vc_allocate+d9/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c018836e <vc_allocate+de/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c0188370 <vc_allocate+e0/f0>
   7:   5b                        pop    %ebx
Code;  c0188371 <vc_allocate+e1/f0>
   8:   5e                        pop    %esi
Code;  c0188372 <vc_allocate+e2/f0>
   9:   5f                        pop    %edi
Code;  c0188373 <vc_allocate+e3/f0>
   a:   c3                        ret
Code;  c0188374 <vc_allocate+e4/f0>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018837a <vc_allocate+ea/f0>
  11:   8d bf 00 00 00 00         lea    0x0(%edi),%edi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0188369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0188369>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc207400   ecx: 00000720   edx: 00000000
esi: 00000050   edi: 00000060   ebp: cfd7e344   esp: cbfa5ea0
ds: 0018   es: 0018   ss: 0018
Stack: cc91d000 00000004 cbfa0405 c0189029 00000004 00000000 00000000 c017f726
       cc91d000 cfd7e344 00000002 cc91d000 cfafa0c4 cbfa5ee8 cbfa4000 cbfa5f84
       00000001 cd5e5009 cfafa0c4 00000005 cfafceb4 c136527c 00000000 00000000
Call Trace: [<c0189029>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00

>>EIP; c0188369 <vc_allocate+d9/f0>   <=====
Trace; c0189029 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c0188369 <vc_allocate+d9/f0>
00000000 <_EIP>:
Code;  c0188369 <vc_allocate+d9/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c018836e <vc_allocate+de/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c0188370 <vc_allocate+e0/f0>
   7:   5b                        pop    %ebx
Code;  c0188371 <vc_allocate+e1/f0>
   8:   5e                        pop    %esi
Code;  c0188372 <vc_allocate+e2/f0>
   9:   5f                        pop    %edi
Code;  c0188373 <vc_allocate+e3/f0>
   a:   c3                        ret
Code;  c0188374 <vc_allocate+e4/f0>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018837a <vc_allocate+ea/f0>
  11:   8d bf 00 00 00 00         lea    0x0(%edi),%edi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0188369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0188369>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc207600   ecx: 00000720   edx: 00000000
esi: 00000050   edi: 00000064   ebp: cc80c874   esp: cbfd5ea0
ds: 0018   es: 0018   ss: 0018
Stack: cbedf000 00000005 cbfd0406 c0189029 00000005 00000000 00000000 c017f726
       cbedf000 cc80c874 00000002 cbedf000 cfafa1cc cbfd5ee8 cbfd4000 cbfd5f84
       00000001 cc09c009 cfafa1cc 00000005 cfaf9190 c1365304 00000000 00000000
Call Trace: [<c0189029>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00

>>EIP; c0188369 <vc_allocate+d9/f0>   <=====
Trace; c0189029 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c0188369 <vc_allocate+d9/f0>
00000000 <_EIP>:
Code;  c0188369 <vc_allocate+d9/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c018836e <vc_allocate+de/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c0188370 <vc_allocate+e0/f0>
   7:   5b                        pop    %ebx
Code;  c0188371 <vc_allocate+e1/f0>
   8:   5e                        pop    %esi
Code;  c0188372 <vc_allocate+e2/f0>
   9:   5f                        pop    %edi
Code;  c0188373 <vc_allocate+e3/f0>
   a:   c3                        ret
Code;  c0188374 <vc_allocate+e4/f0>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018837a <vc_allocate+ea/f0>
  11:   8d bf 00 00 00 00         lea    0x0(%edi),%edi

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0188369
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0188369>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc207800   ecx: 00000720   edx: 00000000
esi: 00000050   edi: 0000005c   ebp: cd89ed94   esp: cbf7fea0
ds: 0018   es: 0018   ss: 0018
Stack: cbea9000 00000003 cbf70404 c0189029 00000003 00000000 00000000 c017f726
       cbea9000 cd89ed94 00000002 cbea9000 cfb09e90 cbf7fee8 cbf7e000 cbf7ff84
       00000001 cc943009 cfb09e90 00000005 cfafcc5c c13651f4 00000000 00000000
Call Trace: [<c0189029>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 8d b6 00 00 00 00 8d bf 00

>>EIP; c0188369 <vc_allocate+d9/f0>   <=====
Trace; c0189029 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c0188369 <vc_allocate+d9/f0>
00000000 <_EIP>:
Code;  c0188369 <vc_allocate+d9/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c018836e <vc_allocate+de/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c0188370 <vc_allocate+e0/f0>
   7:   5b                        pop    %ebx
Code;  c0188371 <vc_allocate+e1/f0>
   8:   5e                        pop    %esi
Code;  c0188372 <vc_allocate+e2/f0>
   9:   5f                        pop    %edi
Code;  c0188373 <vc_allocate+e3/f0>
   a:   c3                        ret
Code;  c0188374 <vc_allocate+e4/f0>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018837a <vc_allocate+ea/f0>
  11:   8d bf 00 00 00 00         lea    0x0(%edi),%edi


18 warnings issued.  Results may not be reliable.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fUHGsYXoezDwaVARApp4AJkB0umawX/276zofc2XXpRqmvMb2QCcDXUM
vLJ7/Ahpcyos8FM0QWo9F2o=
=8mrm
-----END PGP SIGNATURE-----

