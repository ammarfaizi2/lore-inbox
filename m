Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQLDPnr>; Mon, 4 Dec 2000 10:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbQLDPnh>; Mon, 4 Dec 2000 10:43:37 -0500
Received: from [216.10.14.151] ([216.10.14.151]:12039 "EHLO virtual.vdi.net")
	by vger.kernel.org with ESMTP id <S129930AbQLDPnb>;
	Mon, 4 Dec 2000 10:43:31 -0500
Date: Mon, 4 Dec 2000 10:13:09 -0500
From: "J. Nick Koston" <lists@bdraco.org>
To: linux-kernel@vger.kernel.org
Subject: Nightly usb oops
Message-ID: <20001204101309.A1368@bdraco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - virtual.vdi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [514 514] / [514 514]
X-AntiAbuse: Sender Address Domain - virtual.vdi.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine crashes almost every night with this oops.  I've finally
managed to catch it before it was totally gone.


ksymoops 2.3.4 on i686 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10 (specified)
     -m /boot/System.map-2.4.0-test10 (specified)

Warning (compare_maps): snd symbol pm_register not found in /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring /lib/modules/2.4.0-test10/misc/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring /lib/modules/2.4.0-test10/misc/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /lib/modules/2.4.0-test10/misc/snd.o.  Ignoring /lib/modules/2.4.0-test10/misc/snd.o entry
      0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=1b, PID=69(IN) (buf=0fe124a4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=1b, PID=e1(OUT) (buf=00000000)
      0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
      0fef3180 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=1b, PID=69(IN) (buf=0fe124a4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=1b, PID=e1(OUT) (buf=00000000)
      0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=1b, PID=69(IN) (buf=0fe124a4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=1b, PID=e1(OUT) (buf=00000000)
      0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
      0fef3180 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=1b, PID=69(IN) (buf=0fe124a4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=1b, PID=e1(OUT) (buf=00000000)
      0fef3340 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=1b, PID=2d(SETUP) (buf=0bd41580)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=1b, PID=69(IN) (buf=0fe124a4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=1b, PID=e1(OUT) (buf=00000000)
      0fef33c0 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=22, PID=2d(SETUP) (buf=0083bf80)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=22, PID=69(IN) (buf=015a6ca4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=22, PID=e1(OUT) (buf=00000000)
      0fef33c0 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=22, PID=2d(SETUP) (buf=0083bf80)
      0fef3340 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=22, PID=69(IN) (buf=015a6ca4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=22, PID=e1(OUT) (buf=00000000)
      0fef33c0 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=22, PID=2d(SETUP) (buf=0083bf80)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=22, PID=69(IN) (buf=015a6ca4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=22, PID=e1(OUT) (buf=00000000)
      0fef33c0 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=22, PID=2d(SETUP) (buf=0083bf80)
      0fef3340 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=22, PID=69(IN) (buf=015a6ca4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=22, PID=e1(OUT) (buf=00000000)
      0fef33c0 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=22, PID=2d(SETUP) (buf=0083bf80)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=22, PID=69(IN) (buf=015a6ca4)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=22, PID=e1(OUT) (buf=00000000)
      0fef3180 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=25, PID=2d(SETUP) (buf=0fe3a300)
      0fef33c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc80)
      0fef3480 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc88)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc90)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc98)
      0fef3400 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca0)
      0fef3280 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca8)
      0fef3340 e3 SPD Active Length=0 MaxLen=6 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bcb0)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=25, PID=e1(OUT) (buf=00000000)
      0fef3280 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=25, PID=2d(SETUP) (buf=0fe3a300)
      0fef3400 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc80)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc88)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc90)
      0fef3480 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc98)
      0fef33c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca0)
      0fef3180 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca8)
      0fef3300 e3 SPD Active Length=0 MaxLen=6 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bcb0)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=25, PID=e1(OUT) (buf=00000000)
      0fef3180 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=25, PID=2d(SETUP) (buf=0fe3a300)
      0fef33c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc80)
      0fef3480 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc88)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc90)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc98)
      0fef3400 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca0)
      0fef3280 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca8)
      0fef3340 e3 SPD Active Length=0 MaxLen=6 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bcb0)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=25, PID=e1(OUT) (buf=00000000)
      0fef3280 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=25, PID=2d(SETUP) (buf=0fe3a300)
      0fef3400 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc80)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc88)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc90)
      0fef3480 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc98)
      0fef33c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca0)
      0fef3180 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca8)
      0fef3300 e3 SPD Active Length=0 MaxLen=6 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bcb0)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=25, PID=e1(OUT) (buf=00000000)
      0fef3180 e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=25, PID=2d(SETUP) (buf=0fe3a300)
      0fef33c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc80)
      0fef3480 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc88)
      0fef31c0 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc90)
      0fef3240 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bc98)
      0fef3400 e3 SPD Active Length=0 MaxLen=7 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca0)
      0fef3280 e3 SPD Active Length=0 MaxLen=7 DT0 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bca8)
      0fef3340 e3 SPD Active Length=0 MaxLen=6 DT1 EndPt=0 Dev=25, PID=69(IN) (buf=0ff2bcb0)
      00000001 e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=25, PID=e1(OUT) (buf=00000000)
Unable to handle kernel NULL pointer dereference at virtual address 00000014
c01faed6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01faed6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000008   ebx: cbd41385   ecx: cbd41380   edx: 00000008
esi: 00000000   edi: cfe12400   ebp: 00000001   esp: c14fdf0c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 7, stackpage=c14fd000)
Stack: cbd41385 00000000 cfe12400 00000001 00000008 00000000 00000009 00000000 
       00000001 00000000 00000000 c01fb1f3 cfe12400 00000000 cfe12400 c5985802 
       cfe12400 00000000 cbd41380 cbd41380 c01fb7f1 cfe12400 00000001 00000000 
Call Trace: [<c01fb1f3>] [<c01fb7f1>] [<c01fcc60>] [<c01fce32>] [<c0293580>] [<c0293647>] [<c01fcfa5>] 
       [<c0105000>] [<c0108c03>] 
Code: 8b 42 0c c7 44 24 24 00 00 00 00 0f b6 72 04 39 74 24 24 0f 

>>EIP; c01faed6 <usb_set_maxpacket+46/120>   <=====
Trace; c01fb1f3 <usb_set_configuration+e3/f0>
Trace; c01fb7f1 <usb_new_device+171/1d0>
Trace; c01fcc60 <usb_hub_port_connect_change+270/300>
Trace; c01fce32 <usb_hub_events+142/270>
Trace; c0293580 <usb_bandwidth_option+1bf8/28ec>
Trace; c0293647 <usb_bandwidth_option+1cbf/28ec>
Trace; c01fcfa5 <usb_hub_thread+45/70>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0108c03 <kernel_thread+23/30>
Code;  c01faed6 <usb_set_maxpacket+46/120>
00000000 <_EIP>:
Code;  c01faed6 <usb_set_maxpacket+46/120>   <=====
   0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
Code;  c01faed9 <usb_set_maxpacket+49/120>
   3:   c7 44 24 24 00 00 00      movl   $0x0,0x24(%esp,1)
Code;  c01faee0 <usb_set_maxpacket+50/120>
   a:   00 
Code;  c01faee1 <usb_set_maxpacket+51/120>
   b:   0f b6 72 04               movzbl 0x4(%edx),%esi
Code;  c01faee5 <usb_set_maxpacket+55/120>
   f:   39 74 24 24               cmp    %esi,0x24(%esp,1)
Code;  c01faee9 <usb_set_maxpacket+59/120>
  13:   0f 00 00                  sldt   (%eax)

Unable to handle kernel NULL pointer dereference at virtual address 00000008
c013ed99
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013ed99>]
EFLAGS: 00010246
eax: 00000008   ebx: 00000000   ecx: 0000000c   edx: 00000002
esi: 00000000   edi: 00000000   ebp: 00000008   esp: c36f3f08
ds: 0018   es: 0018   ss: 0018
Process initlog (pid: 532, stackpage=c36f3000)
Stack: c36f2000 00000000 00000002 00000000 0000000c 0000000e c013eec3 00000002 
       00000008 c36f3f48 c36f3f4c c36f2000 00000002 00000002 00000000 c36f2000 
       00000000 00000000 c013f133 00000002 00000000 00000002 cbd41140 c36f3fb8 
Call Trace: [<c013eec3>] [<c013f133>] [<c01203ed>] [<c010a637>] 
Code: 8b 45 00 85 c0 7c 59 e8 6b 1f ff ff 89 c6 bb 20 00 00 00 85 

>>EIP; c013ed99 <do_pollfd+29/b0>   <=====
Trace; c013eec3 <do_poll+a3/e0>
Trace; c013f133 <sys_poll+233/350>
Trace; c01203ed <sys_nanosleep+10d/190>
Trace; c010a637 <system_call+33/38>
Code;  c013ed99 <do_pollfd+29/b0>
00000000 <_EIP>:
Code;  c013ed99 <do_pollfd+29/b0>   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  c013ed9c <do_pollfd+2c/b0>
   3:   85 c0                     test   %eax,%eax
Code;  c013ed9e <do_pollfd+2e/b0>
   5:   7c 59                     jl     60 <_EIP+0x60> c013edf9 <do_pollfd+89/b0>
Code;  c013eda0 <do_pollfd+30/b0>
   7:   e8 6b 1f ff ff            call   ffff1f77 <_EIP+0xffff1f77> c0130d10 <fget+0/30>
Code;  c013eda5 <do_pollfd+35/b0>
   c:   89 c6                     mov    %eax,%esi
Code;  c013eda7 <do_pollfd+37/b0>
   e:   bb 20 00 00 00            mov    $0x20,%ebx
Code;  c013edac <do_pollfd+3c/b0>
  13:   85 00                     test   %eax,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 00000040
c013ed99
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013ed99>]
EFLAGS: 00210246
eax: 00000040   ebx: 00000000   ecx: 00000044   edx: 00000006
esi: 00000000   edi: 00000000   ebp: 00000040   esp: c09a7f08
ds: 0018   es: 0018   ss: 0018
Process deskguide_apple (pid: 835, stackpage=c09a7000)
Stack: c09a6000 00000000 00000006 00000000 00000044 00000046 c013eec3 00000006 
       00000040 c09a7f48 c09a7f4c c09a6000 00000006 00000006 00000000 c09a6000 
       00000000 00000000 c013f133 00000006 00000000 00000006 cbd41880 c09a7fb8 
Call Trace: [<c013eec3>] [<c013f133>] [<c010a637>] 
Code: 8b 45 00 85 c0 7c 59 e8 6b 1f ff ff 89 c6 bb 20 00 00 00 85 

>>EIP; c013ed99 <do_pollfd+29/b0>   <=====
Trace; c013eec3 <do_poll+a3/e0>
Trace; c013f133 <sys_poll+233/350>
Trace; c010a637 <system_call+33/38>
Code;  c013ed99 <do_pollfd+29/b0>
00000000 <_EIP>:
Code;  c013ed99 <do_pollfd+29/b0>   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  c013ed9c <do_pollfd+2c/b0>
   3:   85 c0                     test   %eax,%eax
Code;  c013ed9e <do_pollfd+2e/b0>
   5:   7c 59                     jl     60 <_EIP+0x60> c013edf9 <do_pollfd+89/b0>
Code;  c013eda0 <do_pollfd+30/b0>
   7:   e8 6b 1f ff ff            call   ffff1f77 <_EIP+0xffff1f77> c0130d10 <fget+0/30>
Code;  c013eda5 <do_pollfd+35/b0>
   c:   89 c6                     mov    %eax,%esi
Code;  c013eda7 <do_pollfd+37/b0>
   e:   bb 20 00 00 00            mov    $0x20,%ebx
Code;  c013edac <do_pollfd+3c/b0>
  13:   85 00                     test   %eax,(%eax)


3 warnings issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
