Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbRLaSgO>; Mon, 31 Dec 2001 13:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287597AbRLaSgF>; Mon, 31 Dec 2001 13:36:05 -0500
Received: from pcd357088.netvigator.com ([203.218.147.88]:6016 "EHLO hingwah")
	by vger.kernel.org with ESMTP id <S287595AbRLaSfs>;
	Mon, 31 Dec 2001 13:35:48 -0500
Date: Tue, 1 Jan 2002 02:35:54 +0800
To: linux-kernel@vger.kernel.org
Subject: kernel oops for 2.4.12
Message-ID: <20011231183554.GA2342@hingwah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: hingwah@computer.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My computer hang when I plug out the USB palm hotsync cable which is
identified as Proliferic usb serial converter which use pl2303.o as module
and plug in the usb mouse
after reboot,the following oops message is found in /var/log/messages
Jan  1 02:14:03 hingwah kernel:  printing eip:
Jan  1 02:14:03 hingwah kernel: c0172816
Jan  1 02:14:03 hingwah kernel: Oops: 0000
Jan  1 02:14:03 hingwah kernel: CPU:    0
Jan  1 02:14:03 hingwah kernel: EIP:    0010:[get_tty_driver+26/72]
Tainted:
PF
Jan  1 02:14:03 hingwah kernel: EFLAGS: 00210282
Jan  1 02:14:03 hingwah kernel: eax: 00000005   ebx: 00000001   ecx:
c0220200
edx: d0b01180
Jan  1 02:14:03 hingwah kernel: esi: 00000005   edi: 00000005   ebp:
c026e744
esp: c5c97f08
Jan  1 02:14:03 hingwah kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 02:14:03 hingwah kernel: Process usbmgr (pid: 5135,
stackpage=c5c97000)
Jan  1 02:14:03 hingwah kernel: Stack: c0220200 00000028 c012d82f
00000501 fffff
fed c4448c60 cff7e600 c14052e0
Jan  1 02:14:03 hingwah kernel:        cff7e600 ffffffeb cad0a000
c0134f87 cff7e
600 c012d999 00000005 00000001
Jan  1 02:14:03 hingwah kernel:        c4448c60 cff7e600 00000000
c012cb15 cff7e
600 c4448c60 0804e282 cad0a000
Jan  1 02:14:03 hingwah kernel: Call Trace: [get_chrfops+103/200]
[permission+43
/48] [chrdev_open+37/76] [dentry_open+225/392] [filp_open+82/92]
Jan  1 02:14:03 hingwah kernel:    [sys_open+54/148] [system_call+51/56]
Jan  1 02:14:03 hingwah kernel:
n  1 02:14:03 hingwah kernel:
Jan  1 02:14:03 hingwah kernel: Code: 0f bf 42 10 39 f0 75 16 0f bf 4a
12 39 cb
7c 0e 0f bf 42 14
Jan  1 02:14:03 hingwah kernel:  <1>Unable to handle kernel paging
request at vi
rtual address d0afe4c4
Jan  1 02:14:03 hingwah kernel:  printing eip:
Jan  1 02:14:03 hingwah kernel: d0afe4c4
Jan  1 02:14:03 hingwah kernel: Oops: 0000
Jan  1 02:14:03 hingwah kernel: CPU:    0
Jan  1 02:14:03 hingwah kernel: EIP:    0010:[<d0afe4c4>]    Tainted: PF
Jan  1 02:14:03 hingwah kernel: EFLAGS: 00010246
Jan  1 02:14:03 hingwah kernel: eax: d0afe4c4   ebx: 00000000   ecx:
c494df58
edx: 00000000
Jan  1 02:14:03 hingwah kernel: esi: 00000000   edi: c7624000   ebp:
c0e75640
esp: c494dee4
Jan  1 02:14:03 hingwah kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 02:14:03 hingwah kernel: Process gpilotd (pid: 6011,
stackpage=c494d000)
Jan  1 02:14:03 hingwah kernel: Stack: c01772a5 c7624000 c7624000
c0e75640 c7a5c
018 00000003 c0173e53 c7624000
Jan  1 02:14:03 hingwah kernel:        c0e75640 00000000 c0e75640
00000145 c0139
605 c0e75640 00000000 00000000
Jan  1 02:14:03 hingwah kernel:        00000000 080c46f8 7fffffff
c01396c9 00000
009 c7a5c000 c494df58 c494df5c
Jan  1 02:14:03 hingwah kernel: Call Trace: [normal_poll+253/296]
[tty_poll+127/
140] [do_pollfd+73/136] [do_poll+133/220] [sys_poll+477/752]
Jan  1 02:14:03 hingwah kernel:    [sock_ioctl+33/40]
[system_call+51/56]
Jan  1 02:14:03 hingwah kernel:
Jan  1 02:14:03 hingwah kernel: Code:  Bad EIP value.
Jan  1 02:14:03 hingwah kernel:  <1>Unable to handle kernel paging
request at vi
rtual address d0b012a0
Jan  1 02:14:03 hingwah kernel:  printing eip:
Jan  1 02:14:03 hingwah kernel: c017365a
Jan  1 02:14:03 hingwah kernel: Oops: 0000
Jan  1 02:14:03 hingwah kernel: CPU:    0
Jan  1 02:14:03 hingwah kernel: EIP:    0010:[release_dev+250/1276]
Tainted:
PF
Jan  1 02:14:03 hingwah kernel: EFLAGS: 00010293
Jan  1 02:14:03 hingwah kernel: eax: d0b012a0   ebx: c7624000   ecx:
00000000
edx: 00000000
Jan  1 02:14:03 hingwah kernel: esi: c46aa060   edi: c14052e0   ebp:
00000000
esp: c494dd14
Jan  1 02:14:03 hingwah kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 02:14:03 hingwah kernel: Process gpilotd (pid: 6011,
stackpage=c494d000)
Jan  1 02:14:03 hingwah kernel: Stack: c4558860 c46aa060 c14052e0
c5a8a7c0 00000
000 c4366e40 c01b2dba 00000000
Jan  1 02:14:03 hingwah kernel:        c823d8a0 c5b5b820 00000246
00000282 c8bcb
ee0 c3f1d460 c1405260 c8bcbee4
Jan  1 02:14:03 hingwah kernel:        00000282 00000001 c36cccc0
c0134868 c03b7
aa0 c3f1d460 c013489e c3f1d460
Jan  1 02:14:03 hingwah kernel: Call Trace: [sock_def_wakeup+34/36]
[pipe_releas
e+116/136] [pipe_write_release+14/20] [tty_release+10/16] [fput+76/208]
Jan  1 02:14:03 hingwah kernel:    [filp_close+92/100]
[put_files_struct+84/188]
 [do_exit+169/460] [do_page_fault+0/1176] [die+79/80]
 [do_page_fault+847/1176]
 Jan  1 02:14:03 hingwah kernel:    [do_page_fault+0/1176]
 [alloc_skb+210/384] [s
 ock_def_readable+38/76] [unix_stream_sendmsg+514/700]
 [error_code+52/60] [normal
 _poll+253/296]
 Jan  1 02:14:03 hingwah kernel:    [tty_poll+127/140]
 [do_pollfd+73/136] [do_pol
 l+133/220] [sys_poll+477/752] [sock_ioctl+33/40] [system_call+51/56]
 Jan  1 02:14:03 hingwah kernel:
 Jan  1 02:14:03 hingwah kernel: Code: 3b 1c 90 74 21 0f b7 83 10 01 00
 00 50 e8
 54 a3 fb ff 50 8b
 




My Computer is IBM Thinkpad 390E

