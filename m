Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285018AbRLLBT5>; Tue, 11 Dec 2001 20:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284849AbRLLBTi>; Tue, 11 Dec 2001 20:19:38 -0500
Received: from smtp-server1.tampabay.rr.com ([65.32.1.34]:44453 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S284944AbRLLBT1> convert rfc822-to-8bit; Tue, 11 Dec 2001 20:19:27 -0500
Message-Id: <200112120119.fBC1JPO23555@smtp-server1.tampabay.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: GNUOrder <gnuorder@tampabay.rr.com>
Reply-To: gnuorder@tampabay.rr.com
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 Kernel error I'm getting.
Date: Tue, 11 Dec 2001 20:17:35 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a slackware 7.1 system with kernel 2.2.19 and I occasionally 
experience a total loss of connection from the outside.  The system is still 
able to run and emails out logs and ports appear open.  I have sshd, proftpd, 
named, webmin, httpd and inetd running and inetd only serves identd.  I cant 
connect to any except httpd seems to work still.  This last time I was able 
to get a log of some kernel errors.  I was hoping this provides some 
information.  This isn't the only time this has happened but the first that I 
could get errors from.  



This first one is oh sh.  I had a ssh session open at the time but it still 
seems to be working fine.  I noticed an irc info bot (not eggdrop or anything 
exploitable like that) timed out.  I typed ps aux to see if it was still 
running and my ssh session locked up.  I think this occured after this error 
though.

Dec  9 00:00:39 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:00:39 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:00:39 quake kernel: current->tss.cr3 = 08018000, %cr3 = 08018000
Dec  9 00:00:39 quake kernel: current->tss.cr3 = 08018000, %cr3 = 08018000
Dec  9 00:00:39 quake kernel: *pde = 00000000
Dec  9 00:00:39 quake kernel: *pde = 00000000
Dec  9 00:00:39 quake kernel: Oops: 0000
Dec  9 00:00:39 quake kernel: Oops: 0000
Dec  9 00:00:39 quake kernel: CPU:    0
Dec  9 00:00:39 quake kernel: CPU:    0
Dec  9 00:00:39 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:00:39 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:00:39 quake kernel: EFLAGS: 00010286
Dec  9 00:00:39 quake kernel: EFLAGS: 00010286
Dec  9 00:00:39 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: 57e00000
Dec  9 00:00:39 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: 57e00000
Dec  9 00:00:39 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: c601fc2c
Dec  9 00:00:39 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: c601fc2c
Dec  9 00:00:39 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:00:39 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:00:39 quake kernel: Process sh (pid: 21624, process nr: 52, 
stackpage=c601f000)
Dec  9 00:00:39 quake kernel: Process sh (pid: 21624, process nr: 52, 
stackpage=c601f000)
Dec  9 00:00:39 quake kernel: Stack: c012bc76 00000001 00000400 00000305 
00000004 ca6f0188 c601fc50 c601fc50 
Dec  9 00:00:39 quake kernel: Stack: c012bc76 00000001 00000400 00000305 
00000004 ca6f0188 c601fc50 c601fc50 
Dec  9 00:00:39 quake kernel:        c601e000 c601e000 00000000 c012c009 
c7504000 00000400 00000001 00000000 
Dec  9 00:00:39 quake kernel:        c601e000 c601e000 00000000 c012c009 
c7504000 00000400 00000001 00000000 
Dec  9 00:00:39 quake kernel:        c601fcf4 00000004 ca6f0188 00000000 
c601fcb4 c7504000 00000003 ca6f0188 
Dec  9 00:00:39 quake kernel:        c601fcf4 00000004 ca6f0188 00000000 
c601fcb4 c7504000 00000003 ca6f0188 
Dec  9 00:00:39 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [get_status+67/1036] [bdflush+193/660] 
[filemap_nopage+355/820] [filemap_nopage+723/820] [filemap_nopage+544/820] 
Dec  9 00:00:39 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [get_status+67/1036] [bdflush+193/660] 
[filemap_nopage+355/820] [filemap_nopage+723/820] [filemap_nopage+544/820] 
Dec  9 00:00:39 quake kernel:        [pipe_read+86/376] [do_pipe+118/392] 
[cached_lookup+61/84] [sys_execve+75/124] [system_call+52/56] 
Dec  9 00:00:39 quake kernel:        [pipe_read+86/376] [do_pipe+118/392] 
[cached_lookup+61/84] [sys_execve+75/124] [system_call+52/56] 
Dec  9 00:00:39 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 
Dec  9 00:00:39 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 



This one is one cron and is likely the crontab that processes logs and info 
and emails it to me.  It runs ps fax, netstat, and other such things and 
processes the  logs into 3 emails, vitals, syslog, and messages.  


Dec  9 00:00:41 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:00:41 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:00:41 quake kernel: current->tss.cr3 = 0c4d9000, %cr3 = 0c4d9000
Dec  9 00:00:41 quake kernel: current->tss.cr3 = 0c4d9000, %cr3 = 0c4d9000
Dec  9 00:00:41 quake kernel: *pde = 00000000
Dec  9 00:00:41 quake kernel: *pde = 00000000
Dec  9 00:00:41 quake kernel: Oops: 0000
Dec  9 00:00:41 quake kernel: Oops: 0000
Dec  9 00:00:41 quake kernel: CPU:    0
Dec  9 00:00:41 quake kernel: CPU:    0
Dec  9 00:00:41 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:00:41 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:00:41 quake kernel: EFLAGS: 00010286
Dec  9 00:00:41 quake kernel: EFLAGS: 00010286
Dec  9 00:00:41 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: d4b80000
Dec  9 00:00:41 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: d4b80000
Dec  9 00:00:41 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: cc4cde50
Dec  9 00:00:41 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: cc4cde50
Dec  9 00:00:41 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:00:41 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:00:41 quake kernel: Process crond (pid: 75, process nr: 13, 
stackpage=cc4cd000)
Dec  9 00:00:41 quake kernel: Process crond (pid: 75, process nr: 13, 
stackpage=cc4cd000)
Dec  9 00:00:41 quake kernel: Stack: c012bc76 00000001 00000400 00000305 
00000004 c9baf3e8 cc4cde74 cc4cde74 
Dec  9 00:00:41 quake kernel: Stack: c012bc76 00000001 00000400 00000305 
00000004 c9baf3e8 cc4cde74 cc4cde74 
Dec  9 00:00:41 quake kernel:        cc4cc000 cc4cc000 00000000 c012c009 
c8569000 00000400 00000001 00000000 
Dec  9 00:00:41 quake kernel:        cc4cc000 cc4cc000 00000000 c012c009 
c8569000 00000400 00000001 00000000 
Dec  9 00:00:41 quake kernel:        cc4cdf18 00000004 c9baf3e8 c0149705 
cc4cded8 c8569000 00000003 c9baf3e8 
Dec  9 00:00:41 quake kernel:        cc4cdf18 00000004 c9baf3e8 c0149705 
cc4cded8 c8569000 00000003 c9baf3e8 
Dec  9 00:00:41 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [get_stat+241/736] [get_status+67/1036] 
[bdflush+193/660] [filemap_nopage+355/820] [filemap_nopage+723/820] 
Dec  9 00:00:41 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [get_stat+241/736] [get_status+67/1036] 
[bdflush+193/660] [filemap_nopage+355/820] [filemap_nopage+723/820] 
Dec  9 00:00:41 quake kernel:        [filemap_nopage+544/820] 
[sys_pwrite+178/332] [system_call+52/56] 
Dec  9 00:00:41 quake kernel:        [filemap_nopage+544/820] 
[sys_pwrite+178/332] [system_call+52/56] 
Dec  9 00:00:41 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 
Dec  9 00:00:41 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 


This error is on the irc bot I was running.  It was the last of the kernel 
errors logged.


Dec  9 00:10:55 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:10:55 quake kernel: Unable to handle kernel paging request at 
virtual address 8000001c
Dec  9 00:10:55 quake kernel: current->tss.cr3 = 0b256000, %cr3 = 0b256000
Dec  9 00:10:55 quake kernel: current->tss.cr3 = 0b256000, %cr3 = 0b256000
Dec  9 00:10:55 quake kernel: *pde = 00000000
Dec  9 00:10:55 quake kernel: *pde = 00000000
Dec  9 00:10:55 quake kernel: Oops: 0000
Dec  9 00:10:55 quake kernel: Oops: 0000
Dec  9 00:10:55 quake kernel: CPU:    0
Dec  9 00:10:55 quake kernel: CPU:    0
Dec  9 00:10:55 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:10:55 quake kernel: EIP:    0010:[brw_page+666/904]
Dec  9 00:10:55 quake kernel: EFLAGS: 00010286
Dec  9 00:10:55 quake kernel: EFLAGS: 00010286
Dec  9 00:10:55 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: 00e80000
Dec  9 00:10:55 quake kernel: eax: 80000000   ebx: 80000000   ecx: 00000000   
edx: 00e80000
Dec  9 00:10:55 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: c8d39e50
Dec  9 00:10:55 quake kernel: esi: 00000c00   edi: 00000001   ebp: 00000400   
esp: c8d39e50
Dec  9 00:10:55 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:10:55 quake kernel: ds: 0018   es: 0018   ss: 0018
Dec  9 00:10:55 quake kernel: Process pwbot (pid: 1826, process nr: 34, 
stackpage=c8d39000)
Dec  9 00:10:55 quake kernel: Process pwbot (pid: 1826, process nr: 34, 
stackpage=c8d39000)
Dec  9 00:10:55 quake kernel: Stack: c012bc76 00000001 00000400 00000341 
00000004 ca95f880 c8d39e74 c8d39e74 
Dec  9 00:10:55 quake kernel: Stack: c012bc76 00000001 00000400 00000341 
00000004 ca95f880 c8d39e74 c8d39e74 
Dec  9 00:10:55 quake kernel:        c8d38000 c8d38000 00000000 c012c009 
c5fe3000 00000400 00000001 00000000 
Dec  9 00:10:55 quake kernel:        c8d38000 c8d38000 00000000 c012c009 
c5fe3000 00000400 00000001 00000000 
Dec  9 00:10:55 quake kernel:        c8d39f18 00000004 ca95f880 c01376cf 
c8d39ed8 c5fe3000 00000003 ca95f880 
Dec  9 00:10:55 quake kernel:        c8d39f18 00000004 ca95f880 c01376cf 
c8d39ed8 c5fe3000 00000003 ca95f880 
Dec  9 00:10:55 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [expand_fdset+95/568] [get_status+67/1036] 
[bdflush+193/660] [try_to_read_ahead+223/276] [filemap_nopage+355/820] 
Dec  9 00:10:55 quake kernel: Call Trace: [brw_page+874/904] 
[show_buffers+153/272] [expand_fdset+95/568] [get_status+67/1036] 
[bdflush+193/660] [try_to_read_ahead+223/276] [filemap_nopage+355/820] 
Dec  9 00:10:55 quake kernel:        [filemap_nopage+723/820] 
[filemap_nopage+544/820] [sys_pwrite+178/332] [system_call+52/56] 
Dec  9 00:10:55 quake kernel:        [filemap_nopage+723/820] 
[filemap_nopage+544/820] [sys_pwrite+178/332] [system_call+52/56] 
Dec  9 00:10:55 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 
Dec  9 00:10:55 quake kernel: Code: 8b 5b 1c 50 e8 99 ff ff ff 83 c4 04 85 db 
75 ee 8b 0d 20 98 

Only other think of note in the logs were a bunch of packets filtered by 
ipchains identical to:


Dec  9 00:11:03 quake kernel: Packet log: input REJECT eth0 PROTO=17 
169.254.176.85:2519 255.255.255.255:2519 L=54 S=0x00 I=9082 F=0x0000 T=128 
(#95)
Dec  9 00:11:33 quake kernel: Packet log: input REJECT eth0 PROTO=17 
169.254.176.85:2519 255.255.255.255:2519 L=54 S=0x00 I=9083 F=0x0000 T=128 
(#95)
Dec  9 00:11:51 quake kernel: Packet log: input REJECT eth0 PROTO=17 
169.254.176.85:3346 255.255.255.255:3346 L=181 S=0x00 I=9084 F=0x0000 T=128 
(#95)
Dec  9 00:12:03 quake kernel: Packet log: input REJECT eth0 PROTO=17 
169.254.176.85:2519 255.255.255.255:2519 L=54 S=0x00 I=9085 F=0x0000 T=128 
(#95)
Dec  9 00:12:33 quake kernel: Packet log: input REJECT eth0 PROTO=17 
169.254.176.85:2519 255.255.255.255:2519 L=54 S=0x00 I=9086 F=0x0000 T=128 
(#95)

Also, most likely unrelated but I found these repeating in one days logs 
while looking for more kernel errors.  What could cause them?


Oct 15 23:55:48 quake kernel: martian source 00000000 for fcef4fcf, dev eth0
Oct 15 23:55:48 quake kernel: martian source 00000000 for fcef4fcf, dev eth0
Oct 15 23:55:48 quake kernel: ll header: 00 80 ad 0d 02 99 00 00 0c 32 65 58 
08 00
Oct 15 23:55:48 quake kernel: ll header: 00 80 ad 0d 02 99 00 00 0c 32 65 58 
08 00
Oct 15 23:55:48 quake kernel: Packet log: input REJECT eth0 PROTO=17 
0.0.0.0:27001 207.79.239.252:27515 L=53 S=0x00 I=27248 F=0x0000 T=20 (#18)

Thanks for any input or insight into the problem.  

GNU Order
