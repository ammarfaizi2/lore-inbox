Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDHOH6>; Sun, 8 Apr 2001 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDHOHt>; Sun, 8 Apr 2001 10:07:49 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:53934 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S132563AbRDHOHa>; Sun, 8 Apr 2001 10:07:30 -0400
Date: Sun, 8 Apr 2001 14:59:14 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OPPS] 2.2.19
Message-ID: <Pine.LNX.4.21.0104081458410.1498-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi

i woke up to these this morning :(

ksymoops 2.3.4 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -L (specified)
     -o /lib/modules/2.2.19/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address d66e8454 
current->tss.cr3 = 01d6f000, %cr3 = 01d6f000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[read_chan+0/1804] 
EFLAGS: 00010286 
eax: bfffe6f0   ebx: c74a6000   ecx: bfffe6f0   edx: c01c01e4 
esi: c6cdb720   edi: c0cc2188   ebp: 00001000   esp: c1d67f84 
ds: 0018   es: 0018   ss: 0018 
Process gnome-terminal (pid: 898, process nr: 51, stackpage=c1d67000) 
Stack: c6cdb720 bfffe6f0 00001000 c6cdb720 ffffffea 00000000 c0124e8e c6cdb720  
       bfffe6f0 00001000 c6cdb734 c1d66000 08336290 bfffe6f0 bffff708 c0109394  
       00000011 bfffe6f0 00001000 08336290 bfffe6f0 bffff708 00000003 c010002b  
Call Trace: [sys_read+174/196] [system_call+52/56] [startup_32+43/286]  
Code: 10 8b 54 24 24 0f ca 85 d2 75 05 31 d2 eb 0b 90 0f bc c2 ba  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   10 8b 54 24 24 0f         adc    %cl,0xf242454(%ebx)
Code;  00000006 Before first symbol
   6:   ca 85 d2                  lret   $0xd285
Code;  00000009 Before first symbol
   9:   75 05                     jne    10 <_EIP+0x10> 00000010 Before first symbol
Code;  0000000b Before first symbol
   b:   31 d2                     xor    %edx,%edx
Code;  0000000d Before first symbol
   d:   eb 0b                     jmp    1a <_EIP+0x1a> 0000001a Before first symbol
Code;  0000000f Before first symbol
   f:   90                        nop    
Code;  00000010 Before first symbol
  10:   0f bc c2                  bsf    %edx,%eax
Code;  00000013 Before first symbol
  13:   ba 00 00 00 00            mov    $0x0,%edx

Unable to handle kernel paging request at virtual address fffff656 
current->tss.cr3 = 0588d000, %cr3 = 0588d000 
*pde = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0010:[schedule+139/644] 
EFLAGS: 00010086 
eax: fffff61a   ebx: c06de000   ecx: 00000002   edx: c06de068 
esi: c1684400   edi: c06de068   ebp: c06de04c   esp: c06de03c 
ds: 0018   es: 0018   ss: 0018 
Process glimmer (pid: 1003, process nr: 46, stackpage=c06dd000) 
Stack: c06de068 fffff61a 08162038 c1684400 c06de070 c0111021 c06de000 c06de000  
       fffff656 c06de000 c06de068 c06de000 c06de114 c06de0f8 c01d6e30 08162518  
       08162500 00000000 c01d8a05 c06de000 00000002 c010e8b8 c06de0f8 08162258  
Call Trace: [__down+77/164] [__down_failed+8/12] [stext_lock+105/13764] [do_page_fault+0/944] [error_code+53/64] [schedule+139/644] [__down+77/164]  
Code: 89 50 3c c7 43 3c 00 00 00 00 c7 43 40 00 00 00 00 c7 43 14  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 3c                  mov    %edx,0x3c(%eax)
Code;  00000003 Before first symbol
   3:   c7 43 3c 00 00 00 00      movl   $0x0,0x3c(%ebx)
Code;  0000000a Before first symbol
   a:   c7 43 40 00 00 00 00      movl   $0x0,0x40(%ebx)
Code;  00000011 Before first symbol
  11:   c7 43 14 00 00 00 00      movl   $0x0,0x14(%ebx)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 0208c000, %cr3 = 0208c000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: ffffddd6   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c2331da4   edi: c7f9af80   ebp: 00000004   esp: c2331d24 
ds: 0018   es: 0018   ss: 0018 
Process xscreensaver (pid: 821, process nr: 48, stackpage=c2331000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c2331da4 c7a51500 c2331d9c  
       c01a2fe2 c7f9af80 00000000 c2331da4 c2331da4 c019d8be c2331da4 00000000  
       c019d7aa c2331da4 c2331e54 00000000 c2331da4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 00792000, %cr3 = 00792000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: ffff2d0d   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c3c53da4   edi: c7f9af80   ebp: 00000004   esp: c3c53d24 
ds: 0018   es: 0018   ss: 0018 
Process netscape-commun (pid: 1456, process nr: 90, stackpage=c3c53000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c3c53da4 c7a51500 c3c53d9c  
       c01a2fe2 c7f9af80 00000000 c3c53da4 c3c53da4 c019d8be c3c53da4 00000000  
       c019d7aa c3c53da4 c3c53e54 00000000 c3c53da4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 02738000, %cr3 = 02738000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff3a288   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c2737da4   edi: c7f9af80   ebp: 00000004   esp: c2737d24 
ds: 0018   es: 0018   ss: 0018 
Process panel (pid: 886, process nr: 41, stackpage=c2737000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c2737da4 c7a51500 c2737d9c  
       c01a2fe2 c7f9af80 00000000 c2737da4 c2737da4 c019d8be c2737da4 00000000  
       c019d7aa c2737da4 c2737e54 00000000 c2737da4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 04dde000, %cr3 = 04dde000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff3a280   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c0877da4   edi: c7f9af80   ebp: 00000004   esp: c0877d24 
ds: 0018   es: 0018   ss: 0018 
Process gnome-session (pid: 9551, process nr: 86, stackpage=c0877000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c0877da4 c7a51500 c0877d9c  
       c01a2fe2 c7f9af80 00000000 c0877da4 c0877da4 c019d8be c0877da4 00000000  
       c019d7aa c0877da4 c0877e54 00000000 c0877da4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 00938000, %cr3 = 00938000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff3a274   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c0937e3c   edi: c7f9af80   ebp: 00000004   esp: c0937dbc 
ds: 0018   es: 0018   ss: 0018 
Process tasklist_applet (pid: 960, process nr: 61, stackpage=c0937000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c0937e3c c7a51500 c0937e34  
       c01a2fe2 c7f9af80 00000000 c0937e3c c0937e3c c019d8be c0937e3c 00000000  
       c019d7aa c0937e3c c0937edc 00000000 c0937e3c c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_getattr+90/128] [__nfs_revalidate_inode+197/416]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 02700000, %cr3 = 02700000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff39b86   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c2719d9c   edi: c7f9af80   ebp: 00000004   esp: c2719d1c 
ds: 0018   es: 0018   ss: 0018 
Process gmc (pid: 884, process nr: 42, stackpage=c2719000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c2719d9c c7a51500 c2719d94  
       c01a2fe2 c7f9af80 00000000 c2719d9c c2719d9c c019d8be c2719d9c 00000000  
       c019d7aa c2719d9c c2719e4c 00000000 c2719d9c c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup+116/200]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 01a76000, %cr3 = 01a76000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff39b7e   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c0877da4   edi: c7f9af80   ebp: 00000004   esp: c0877d24 
ds: 0018   es: 0018   ss: 0018 
Process gnome-session (pid: 9553, process nr: 61, stackpage=c0877000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c0877da4 c7a51500 c0877d9c  
       c01a2fe2 c7f9af80 00000000 c0877da4 c0877da4 c019d8be c0877da4 00000000  
       c019d7aa c0877da4 c0877e54 00000000 c0877da4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 02666000, %cr3 = 02666000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff39098   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c26afd90   edi: c7f9af80   ebp: 00000004   esp: c26afd10 
ds: 0018   es: 0018   ss: 0018 
Process sawfish (pid: 820, process nr: 45, stackpage=c26af000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c26afd90 c7a51500 c26afd88  
       c01a2fe2 c7f9af80 00000000 c26afd90 c26afd90 c019d8be c26afd90 00000000  
       c019d7aa c26afd90 c26afe40 00000000 c26afd90 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 07d1b000, %cr3 = 07d1b000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff389be   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c7d1fda4   edi: c7f9af80   ebp: 00000004   esp: c7d1fd24 
ds: 0018   es: 0018   ss: 0018 
Process gdm (pid: 759, process nr: 6, stackpage=c7d1f000) 
Stack: c7f9af80 00000000 c01a2edc c7f9af80 c7f9af80 c7d1fda4 c7a51500 c7d1fd9c  
       c01a2fe2 c7f9af80 00000000 c7d1fda4 c7d1fda4 c019d8be c7d1fda4 00000000  
       c019d7aa c7d1fda4 c7d1fe54 00000000 c7d1fda4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f 
current->tss.cr3 = 07d1b000, %cr3 = 07d1b000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[rpcauth_gc_credcache+48/152] 
EFLAGS: 00010202 
eax: fff383e0   ebx: 00000000   ecx: c7f9af90   edx: 00000007 
esi: c7d1fda4   edi: c7f9af80   ebp: 00000004   esp: c7d1fd24 
ds: 0018   es: 0018   ss: 0018 
Process gdm (pid: 9555, process nr: 6, stackpage=c7d1f000) 
Stack: c7f9af80 00000004 c01a2edc c7f9af80 c7f9af80 c7d1fda4 c7a51500 c7d1fd9c  
       c01a2fe2 c7f9af80 00000004 c7d1fda4 c7d1fda4 c019d8be c7d1fda4 00000000  
       c019d7aa c7d1fda4 c7d1fe54 00000000 c7d1fda4 c7a51500 00000000 00000000  
Call Trace: [rpcauth_lookup_credcache+64/156] [rpcauth_bindcred+58/84] [rpc_call_setup+58/108] [rpc_call_sync+102/160] [rpc_run_timer+0/68] [nfs_proc_lookup+144/184] [nfs_lookup_revalidate+286/500]  
Code: 66 83 7a 08 00 75 1d a1 40 4c 20 c0 8b 72 04 29 c6 89 f0 85  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 83 7a 08 00            cmpw   $0x0,0x8(%edx)
Code;  00000005 Before first symbol
   5:   75 1d                     jne    24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000007 Before first symbol
   7:   a1 40 4c 20 c0            mov    0xc0204c40,%eax
Code;  0000000c Before first symbol
   c:   8b 72 04                  mov    0x4(%edx),%esi
Code;  0000000f Before first symbol
   f:   29 c6                     sub    %eax,%esi
Code;  00000011 Before first symbol
  11:   89 f0                     mov    %esi,%eax
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel paging request at virtual address 90c3becb 
current->tss.cr3 = 03867000, %cr3 = 03867000 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[find_inode+30/92] 
EFLAGS: 00010283 
eax: 00000032   ebx: 90c3be63   ecx: 00000000   edx: c7f9b400 
esi: 90c3be63   edi: 00000000   ebp: c0230d90   esp: c3579eec 
ds: 0018   es: 0018   ss: 0018 
Process rc (pid: 9576, process nr: 37, stackpage=c3579000) 
Stack: 0000fd35 c7f9b400 c01319d1 c7f9b400 0000fd35 c0230d90 00000000 00000000  
       0000fd35 c219f660 c7fe8ab8 c7fe8b04 c0131a1f c7f9b400 0000fd35 00000000  
       00000000 c013dd18 c7f9b400 0000fd35 fffffff4 c219f660 c7fe8ab8 c652f270  
Call Trace: [iget4+53/112] [iget+19/24] [ext2_lookup+84/124] [real_lookup+79/160] [lookup_dentry+296/488] [__namei+40/88] [sys_newstat+14/96]  
Code: 39 53 68 75 29 8b 54 24 18 39 53 18 75 20 85 ff 74 14 8b 54  

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 53 68                  cmp    %edx,0x68(%ebx)
Code;  00000003 Before first symbol
   3:   75 29                     jne    2e <_EIP+0x2e> 0000002e Before first symbol
Code;  00000005 Before first symbol
   5:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000009 Before first symbol
   9:   39 53 18                  cmp    %edx,0x18(%ebx)
Code;  0000000c Before first symbol
   c:   75 20                     jne    2e <_EIP+0x2e> 0000002e Before first symbol
Code;  0000000e Before first symbol
   e:   85 ff                     test   %edi,%edi
Code;  00000010 Before first symbol
  10:   74 14                     je     26 <_EIP+0x26> 00000026 Before first symbol
Code;  00000012 Before first symbol
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  3:00pm  up 12 days, 22:55,  5 users,  load average: 0.88, 0.77, 0.57

