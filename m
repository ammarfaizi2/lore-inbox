Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSGGXe0>; Sun, 7 Jul 2002 19:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGGXeZ>; Sun, 7 Jul 2002 19:34:25 -0400
Received: from [210.50.30.70] ([210.50.30.70]:16396 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S314085AbSGGXeX>; Sun, 7 Jul 2002 19:34:23 -0400
Message-ID: <3D28D021.3090806@iprimus.com.au>
Date: Mon, 08 Jul 2002 09:34:57 +1000
From: Jarda Gress <jgress@iprimus.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgress@iprimus.com.au
Subject: Crash
Content-Type: multipart/mixed;
 boundary="------------070107040203060202040509"
X-OriginalArrivalTime: 07 Jul 2002 23:35:14.0374 (UTC) FILETIME=[F18CF660:01C2260E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107040203060202040509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The kernel oops.
I think its in driver for sda. I have 2 IDE drives. One cdrom and one zip.
No scsi controlers or devices.
Attached is the log.
Thanks for delivering this to the right persdon.
Jarda



--------------070107040203060202040509
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Jul  7 01:49:37 localhost syslogd 1.4.1: restart.
Jul  7 01:50:04 localhost net_monitor.real[1671]: launched command: /usr/sbin/logdrake --file=/var/log/messages &
Jul  7 01:50:08 localhost net_monitor.real[1671]: launched command: /usr/sbin/logdrake --file=/var/log/messages &
Jul  7 01:50:09 localhost logdrake[1876]: ### Program is starting ###
Jul  7 01:50:13 localhost net_monitor.real[1671]: launched command: /usr/sbin/logdrake --file=/var/log/messages &
Jul  7 01:50:19 localhost logdrake[1878]: ### Program is starting ###
Jul  7 01:50:21 localhost dhcpcd[1710]: timed out waiting for a valid DHCP server response 
Jul  7 01:50:26 localhost logdrake[1880]: ### Program is starting ###
Jul  7 01:51:11 localhost kernel: CSLIP: code copyright 1989 Regents of the University of California
Jul  7 01:51:11 localhost kernel: PPP generic driver version 2.4.1
Jul  7 01:51:11 localhost pppd[1892]: pppd 2.4.1 started by jarda, uid 501
Jul  7 01:51:11 localhost pppd[1892]: Using interface ppp0
Jul  7 01:51:11 localhost pppd[1892]: Connect: ppp0 <--> /dev/tts/1
Jul  7 01:51:35 localhost pppd[1892]: Hangup (SIGHUP)
Jul  7 01:51:35 localhost pppd[1892]: Modem hangup
Jul  7 01:51:35 localhost pppd[1892]: Connection terminated.
Jul  7 01:51:35 localhost pppd[1892]: Exit.
Jul  7 01:52:18 localhost pppd[1900]: pppd 2.4.1 started by jarda, uid 501
Jul  7 01:52:18 localhost pppd[1900]: Using interface ppp0
Jul  7 01:52:18 localhost pppd[1900]: Connect: ppp0 <--> /dev/tts/1
Jul  7 01:52:22 localhost kernel: PPP BSD Compression module registered
Jul  7 01:52:23 localhost kernel: PPP Deflate Compression module registered
Jul  7 01:52:23 localhost pppd[1900]: local  IP address 210.50.68.22
Jul  7 01:52:23 localhost pppd[1900]: remote IP address 192.168.34.1
Jul  7 01:52:23 localhost pppd[1900]: primary   DNS address 203.134.64.66
Jul  7 01:52:23 localhost pppd[1900]: secondary DNS address 203.134.65.66
Jul  7 01:53:44 localhost kernel: Device not ready.  Make sure there is a disc in the drive.
Jul  7 01:53:44 localhost kernel: sda : READ CAPACITY failed.
Jul  7 01:53:44 localhost kernel: sda : status = 0, message = 00, host = 0, driver = 28 
Jul  7 01:53:44 localhost kernel: Current sd00:00: sense key Not Ready
Jul  7 01:53:44 localhost kernel: Additional sense indicates Medium not present
Jul  7 01:53:44 localhost kernel: sda : block size assumed to be 512 bytes, disk size 1GB.  
Jul  7 01:53:44 localhost kernel:  /dev/scsi/host0/bus0/target0/lun0: I/O error: dev 08:00, sector 0
Jul  7 01:53:44 localhost kernel:  I/O error: dev 08:00, sector 0
Jul  7 01:53:44 localhost kernel: Unable to handle kernel paging request at virtual address 204f2f8d
Jul  7 01:53:44 localhost kernel:  printing eip:
Jul  7 01:53:44 localhost kernel: c0160783
Jul  7 01:53:44 localhost kernel: *pde = 00000000
Jul  7 01:53:44 localhost kernel: Oops: 0000
Jul  7 01:53:44 localhost kernel: CPU:    0
Jul  7 01:53:44 localhost kernel: EIP:    0010:[scan_dir_for_removable+19/64]    Tainted: P 
Jul  7 01:53:44 localhost kernel: EIP:    0010:[<c0160783>]    Tainted: P 
Jul  7 01:53:44 localhost kernel: EFLAGS: 00010202
Jul  7 01:53:44 localhost kernel: eax: c4b4dd20   ebx: 204f2f49   ecx: 00000000   edx: c4b4dd20
Jul  7 01:53:44 localhost kernel: esi: c54cb500   edi: c58efb60   ebp: c18525c0   esp: c4f03f28
Jul  7 01:53:44 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  7 01:53:44 localhost kernel: Process msec_find (pid: 1873, stackpage=c4f03000)
Jul  7 01:53:44 localhost kernel: Stack: c54cb500 c0160c16 c58efb60 c0265a40 00000000 c54cb500 c54cb580 c54cb56c 
Jul  7 01:53:44 localhost kernel:        c18525c0 c0141690 c18525c0 c4f03fa0 c0141b90 c18525c0 fffffff7 0000000d 
Jul  7 01:53:44 localhost kernel:        bfffeae8 c0141d3f c18525c0 c0141b90 c4f03fa0 c5816c40 c01338f7 c5816c40 
Jul  7 01:53:44 localhost kernel: Call Trace: [devfs_readdir+86/448] [vfs_readdir+96/144] [filldir64+0/352] [sys_getdents64+79/185] [filldir64+0/352] 
Jul  7 01:53:44 localhost kernel: Call Trace: [<c0160c16>] [<c0141690>] [<c0141b90>] [<c0141d3f>] [<c0141b90>] 
Jul  7 01:53:44 localhost kernel:    [sys_fchdir+199/224] [system_call+51/64] 
Jul  7 01:53:44 localhost kernel:    [<c01338f7>] [<c0106f23>] 
Jul  7 01:53:44 localhost kernel: 
Jul  7 01:53:44 localhost kernel: Code: 66 8b 43 44 25 00 f0 00 00 66 3d 00 60 75 0d f6 43 10 04 74 
Jul  7 01:53:56 localhost anacron[1285]: Job `cron.daily' terminated (mailing output)
Jul  7 02:01:00 localhost CROND[2006]: (root) CMD (nice -n 19 run-parts /etc/cron.hourly) 
Jul  7 02:06:07 localhost init: Switching to runlevel: 0
Jul  7 02:06:10 localhost autologin(pam_unix)[1388]: session closed for user jarda
Jul  7 02:07:45 localhost init: Switching to runlevel: 6
Jul  7 02:14:22 localhost syslogd 1.4.1: restart.
Jul  7 02:14:22 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.

--------------070107040203060202040509--

