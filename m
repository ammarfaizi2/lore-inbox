Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSBDThW>; Mon, 4 Feb 2002 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSBDThM>; Mon, 4 Feb 2002 14:37:12 -0500
Received: from mailhub.dartmouth.edu ([129.170.16.6]:51205 "EHLO
	mailhub.Dartmouth.EDU") by vger.kernel.org with ESMTP
	id <S287421AbSBDTg6>; Mon, 4 Feb 2002 14:36:58 -0500
X-Disclaimer: This message was received from outside Dartmouth's BlitzMail system.
Date: Mon, 04 Feb 2002 14:36:47 -0500
From: "Joseph L. Hill" <joseph.l.hill@Dartmouth.EDU>
Reply-To: "Joseph L. Hill" <joseph.l.hill@Dartmouth.EDU>
To: linux-kernel@vger.kernel.org
Subject: NETDEV WATCHDOG timeout
Message-ID: <159400000.1012851407@localhost>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have  2.4.7-10smp (RedHat 7.2 install) running on a dell on a dell 2550, 
the systems runs a mysql/apache applicaton (blackboard). Several times a 
day, as the load increases I get the following error:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx hung

The system pauses for 3-5 seconds during this error and then continues 
happily.


dmesg info:

Jan 20 17:14:40 dewey kernel: eth0: Broadcom BCM5700 found at mem feb00000, 
IRQ 17, node addr 00065b3a09fc
Jan 20 17:14:40 dewey kernel: eth0: Broadcom BCM5401 Copper transceiver 
found
Jan 20 17:14:40 dewey kernel: eth0: Scatter-gather ON, 64-bit DMA ON, Tx 
Checksum ON, Rx Checksum ON
Jan 20 17:14:40 dewey kernel: bcm5700: eth0 NIC Link is UP, 100 Mbps full 
duplex
Jan 20 17:14:39 dewey network: Bringing up interface eth0:  succeeded
Jan 21 09:04:36 dewey kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 21 09:04:36 dewey kernel: eth0: Tx hung

Is this a hardware error? Should I upgrade to the 2.4.9.13 kernel? Any 
advice appreciated!
Please cc joseph.l.hill@dartmouth.edu in reply.

Thanks you,

-joe


---------------------------
joseph.l.hill@dartmouth.edu
(603) 646-0387
---------------------------
