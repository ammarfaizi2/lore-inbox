Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263075AbTCLH2r>; Wed, 12 Mar 2003 02:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263076AbTCLH2r>; Wed, 12 Mar 2003 02:28:47 -0500
Received: from smtp.cs.curtin.edu.au ([134.7.1.1]:24984 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S263075AbTCLH2q>; Wed, 12 Mar 2003 02:28:46 -0500
Message-ID: <041b01c2e86a$870822f0$64070786@synack>
From: "David Shirley" <dave@cs.curtin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: Help, eth0: transmit timed out!
Date: Wed, 12 Mar 2003 13:23:43 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Just installed Redhat 7.3 on an Athlon 2000 system (2.4.20).

We have a 3c905c network card, and when I try copying files from an nfs
 mount I get this in the logs:

Mar 12 13:15:11 ark kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 12 13:15:11 ark kernel: eth0: transmit timed out, tx_status 00 status
e000.
Mar 12 13:15:11 ark kernel:   diagnostics: net 0cc6 media 8880 dma 000000a0.
Mar 12 13:15:11 ark kernel:   Flags; bus-master 1, dirty 4048(0) current
4064(0)
Mar 12 13:15:11 ark kernel:   Transmit list fffffff8 vs. f7ea9200.
Mar 12 13:15:11 ark kernel:   0: @f7ea9200  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   1: @f7ea9240  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   2: @f7ea9280  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   3: @f7ea92c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   4: @f7ea9300  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   5: @f7ea9340  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   6: @f7ea9380  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   7: @f7ea93c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   8: @f7ea9400  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   9: @f7ea9440  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   10: @f7ea9480  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   11: @f7ea94c0  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   12: @f7ea9500  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   13: @f7ea9540  length 800000b6 status 000000b6
Mar 12 13:15:11 ark kernel:   14: @f7ea9580  length 800000b6 status 800000b6
Mar 12 13:15:11 ark kernel:   15: @f7ea95c0  length 800000b6 status 800000b6
Mar 12 13:15:11 ark kernel: eth0: Resetting the Tx ring pointer.

Usually the machine freezes up after this, and I can't ping it, and when I
press
CTRL-ALT-DEL i get "INIT: cannot execute "echo"" and have to hit reset.

However this last time the machine came back after about 3 secs of no
network activity.

Now I was looking at some info on google, and people said to turn off
IO-APIC
in the kernel, but this was for 2.4.5, has this been fixed in 2.4.20?

Cheers
Dave

/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

