Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbTB0QqE>; Thu, 27 Feb 2003 11:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbTB0QqD>; Thu, 27 Feb 2003 11:46:03 -0500
Received: from tag.witbe.net ([81.88.96.48]:36616 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S265675AbTB0QqC>;
	Thu, 27 Feb 2003 11:46:02 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: "'Paul Rolland'" <rol@as2917.net>
Subject: eepro100: wait_for_cmd_done timeout
Date: Thu, 27 Feb 2003 17:56:21 +0100
Message-ID: <01e601c2de81$27527ce0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a server that has gone thru that :
21:30:02.231737 rms-01 network: Result 0 for gateway 192.168.0.254
Feb 26 21:30:29 rms-01 Feb 26 21:30:29:517449 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 26 21:30:30 rms-01 Feb 26 21:30:30:514068 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 26 21:30:30 rms-01 Feb 26 21:30:30:514094 kernel: eepro100:
wait_for_cmd_don
e timeout!
...
Feb 27 13:48:15 rms-01 Feb 27 13:48:15:940827 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 27 13:48:16 rms-01 Feb 27 13:48:16:940946 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 27 13:48:20 rms-01 Feb 27 13:48:20:766987 kernel: NETDEV WATCHDOG:
eth0: tra
nsmit timed out
Feb 27 13:48:20 rms-01 Feb 27 13:48:20:767007 kernel: eth0: Transmit
timed out: 
status 0090  0c80 at 162209/162269 command 000ca000.
Feb 27 13:48:20 rms-01 Feb 27 13:48:20:842320 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 27 13:48:20 rms-01 Feb 27 13:48:20:842333 kernel: eepro100:
wait_for_cmd_don
e timeout!
Feb 27 13:50:01 rms-01 Feb 27 13:50:01:30726 kernel: eepro100:
wait_for_cmd_done
 timeout!

The only way to get it out of that is a reboot...
The kernel is a 2.4.19 and dmesg says :
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@sa
w.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:06:5B:39:69:2B, IRQ 16.
  Board assembly 02d484-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:06:5B:39:69:2C, IRQ 17.
  Board assembly 02d484-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).

Anyone knows why ?

Regards,
Paul

