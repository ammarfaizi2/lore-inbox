Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbTC2CCm>; Fri, 28 Mar 2003 21:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbTC2CCm>; Fri, 28 Mar 2003 21:02:42 -0500
Received: from ip64-75-165-104.hsia.aloha.net ([64.75.165.104]:384 "EHLO
	backup.mbcloans.com") by vger.kernel.org with ESMTP
	id <S263374AbTC2CCl>; Fri, 28 Mar 2003 21:02:41 -0500
Date: Fri, 28 Mar 2003 18:13:51 -0800
From: Lee Howard <faxguy@howardsilvan.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at buffer.c:509!
Message-ID: <20030329021351.GC26881@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

I'm assuming that this was a freak occurrence as it's the first time 
it's ever happened, but...

Running kernel 2.4.20 on an AMD Athlon XP.  This morning it crashed 
just after some ftp-ing backup routines started.  Here's the log...

Mar 28 02:10:22 backup ctl_cyrusdb[5015]: checkpointing cyrus databases
Mar 28 02:10:22 backup ctl_cyrusdb[5015]: done checkpointing cyrus 
databases
Mar 28 02:14:39 backup ftpd[5017]: FTP LOGIN FROM 10.10.10.246 
[10.10.10.246], backup
Mar 28 02:14:49 backup kernel: kernel BUG at buffer.c:509!
Mar 28 02:14:49 backup kernel: invalid operand: Mar 28 16:05:05 backup 
syslogd 1.4-0: restart.
Mar 28 16:05:05 backup syslog: syslogd startup succeeded
Mar 28 16:05:05 backup kernel: klogd 1.4-0, log source = /proc/kmsg 
started.
Mar 28 16:05:05 backup kernel: Inspecting /boot/System.map

Hope it serves some purpose for someone.

Thanks.

Lee.
