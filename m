Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132272AbRCYJjf>; Sun, 25 Mar 2001 04:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132274AbRCYJjZ>; Sun, 25 Mar 2001 04:39:25 -0500
Received: from mail-1.tiscalinet.it ([195.130.225.147]:12445 "EHLO
	mail.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S132272AbRCYJjN>; Sun, 25 Mar 2001 04:39:13 -0500
Date: Sun, 25 Mar 2001 11:35:51 +0200
To: debian-users@lists.debian.org, linux-kernel@vger.kernel.org
Subject: kernel gen prot fault
Message-ID: <20010325113551.A2838@etabeta.sns.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: A C G Mennucc <debian@Tonelli.sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


hi

please help!

my Debian system , (Pentium 133)  which has run seamlessly for 5 years 
(thru several upgrades of SW and HW)
is now totally unrealible , and has been for 15 days :
from time to time, apprx once a day, 
it suddenly freezes , for no apparent reasons; then, it doesnt even respond
to ping from the net

I have tried many approaches : 
1) cleaned the heatsink and the fan (which actually had stuck, but now
 is running fine)
2) tried changing : video card , motherboard & CPU, memory , ethernet card
 ( I work in a university, we have a lot of old spare parts)

so I am left with no ideas of what I should do, my last chances are
1) change HD (but this one was bought 3 months ago !)
2) buy a new PC altogether
3) bang my head on the wall (yes, when it crashed on friday evening after the 
 3rd total rearragnment of HW, I had that temptation)

the only sign that I have had are some 'general protection faults'
from the kernel which I cant 'decrypt'

I am running kernel 2.2.18 ( Debian packaging)

I attach a file , may  you please tell me if that message 
can suggest a solution to the prbl

thanks thanks for any hint

a.


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.panic"

/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: general protection fault: 2000
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: CPU:    0
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: EIP:    0010:[load_elf_interp+398/700]
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: EFLAGS: 00013202
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: eax: 00000005   ebx: c0e746c0   ecx: c03b5db0   edx: c197e970
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: esi: 00000000   edi: c03b5db0   ebp: 00000000   esp: c03b5cd8
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: ds: 0018   es: 0018   ss: 0018
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: Process sh (pid: 19916, process nr: 73, stackpage=c03b5000)
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: Stack: 00000000 c107f610 00000005 00000802 00000000 00000004 ffffffff 00000000 
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel:        00000000 00000000 c0e746c0 c197e970 c0136412 c03b5db0 c1f52460 c03b5d80 
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel:        c02b68a0 c03b4000 fffffff8 c03b5e68 00000000 00000080 080b2320 c09feb5c 
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: Call Trace: [load_elf_binary+1862/2696] [search_binary_handler+70/300] [do_execve+387/488] [do_execve+420/488] [sys_execve+44/88] [system_call+52/56] 
/var/log/syslog.4.gz:Mar 16 15:24:03 Tonelli kernel: Code: 64 07 83 7c 24 2c 00 74 08 c7 44 24 14 12 08 00 00 8b 43 08 

/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: general protection fault: 2000
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: CPU:    0
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EIP:    0010:[load_elf_interp+398/700]
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EFLAGS: 00010202
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: eax: 00000005   ebx: c0e74870   ecx: c1965db0   edx: c1852a80
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: esi: 00000000   edi: c1965db0   ebp: 00000000   esp: c1965cd8
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: ds: 0018   es: 0018   ss: 0018
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Process sh (pid: 19921, process nr: 97, stackpage=c1965000)
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Stack: 00000000 c107fb60 00000005 00000802 00000000 00000004 ffffffff 00000000 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        00000000 00000000 c0e74870 c1852a80 c0136412 c1965db0 c1f52460 c1965d80 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        c02b68a0 c1964000 fffffff8 c1965e68 00000000 00000080 080b2320 c09fee9c 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Call Trace: [load_elf_binary+1862/2696] [search_binary_handler+70/300] [do_execve+387/488] [do_execve+420/488] [sys_execve+44/88] [system_call+52/56] 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Code: 64 07 83 7c 24 2c 00 74 08 c7 44 24 14 12 08 00 00 8b 43 08 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: general protection fault: 2000
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: CPU:    0
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EIP:    0010:[load_elf_interp+398/700]
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EFLAGS: 00010202
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: eax: 00000005   ebx: c10f9ac0   ecx: c0bf9db0   edx: c0a880c0
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: esi: 00000000   edi: c0bf9db0   ebp: 00000000   esp: c0bf9cd8
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: ds: 0018   es: 0018   ss: 0018
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Process sh (pid: 19922, process nr: 91, stackpage=c0bf9000)
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Stack: 00000000 c107fd80 00000005 00000802 00000000 00000004 ffffffff 00000000 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        00000000 00000000 c10f9ac0 c0a880c0 c0136412 c0bf9db0 c1f52460 c0bf9d80 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        c02b68a0 c0bf8000 fffffff8 c0bf9e68 00000000 00000080 080b2320 c09fe33c 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Call Trace: [load_elf_binary+1862/2696] [search_binary_handler+70/300] [do_execve+387/488] [do_execve+420/488] [sys_execve+44/88] [system_call+52/56] 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Code: 64 07 83 7c 24 2c 00 74 08 c7 44 24 14 12 08 00 00 8b 43 08 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: general protection fault: 2000
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: CPU:    0
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EIP:    0010:[load_elf_interp+398/700]
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: EFLAGS: 00010202
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: eax: 00000005   ebx: c0e74cf0   ecx: c186ddb0   edx: c197e610
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: esi: 00000000   edi: c186ddb0   ebp: 00000000   esp: c186dcd8
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: ds: 0018   es: 0018   ss: 0018
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Process sh (pid: 19923, process nr: 93, stackpage=c186d000)
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Stack: 00000000 c107f500 00000005 00000802 00000000 00000004 ffffffff 00000000 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        00000000 00000000 c0e74cf0 c197e610 c0136412 c186ddb0 c1f52460 c186dd80 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel:        c02b68a0 c186c000 fffffff8 c186de68 00000000 00000080 080b2320 c09fecfc 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Call Trace: [load_elf_binary+1862/2696] [search_binary_handler+70/300] [do_execve+387/488] [do_execve+420/488] [sys_execve+44/88] [system_call+52/56] 
/var/log/syslog.4.gz:Mar 16 15:25:03 Tonelli kernel: Code: 64 07 83 7c 24 2c 00 74 08 c7 44 24 14 12 08 00 00 8b 43 08 

--MGYHOYXEY6WxJCY8--
