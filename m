Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSKHWjV>; Fri, 8 Nov 2002 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbSKHWjU>; Fri, 8 Nov 2002 17:39:20 -0500
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:60933 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S262662AbSKHWjT> convert rfc822-to-8bit; Fri, 8 Nov 2002 17:39:19 -0500
From: "Stephane Charette" <scharette@packeteer.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Date: Fri, 08 Nov 2002 14:46:01 -0800
Reply-To: "Stephane Charette" <scharette@packeteer.com>
X-Mailer: PMMail 2000 Standard (2.20.2502) For Windows 2000 (5.0.2195;2)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: panic not rebooting even though /proc/sys/kernel/panic=1?
Message-Id: <20021108223919Z262662-32597+18896@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know why a kernel panic would not cause a reboot even though /proc/sys/kernel/panic is set to "1"?

This morning I had the following message on the console of a 2.2.14 box that had been sitting idle overnight:

   [root@localhost /test]# Kernel panic: Free list corrupted

When I pressed ENTER, I found that bash was still responding, though when I tried to run "top" everything froze until I pulled the plug on the box:

   [root@localhost /test]# ls -la
   total 3
   drwxr-x---    2 root     root         1024 Nov  7 23:56 .
   drwxr-xr-x   13 root     root         1024 Nov  7 19:56 ..
   -rw-------    1 root     root            5 Nov  7 23:56 test.txt
   [root@localhost /test]# 
   [root@localhost /test]# top
   Kernel panic: Free list corrupted

1) Anyone know why the kernel panic didn't cause a reboot?

2) Or maybe why something like this would even happen?

Thanks,

Stéphane Charette


