Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbRDRLfP>; Wed, 18 Apr 2001 07:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbRDRLfG>; Wed, 18 Apr 2001 07:35:06 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:7950 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S133086AbRDRLew>; Wed, 18 Apr 2001 07:34:52 -0400
Date: Wed, 18 Apr 2001 13:34:43 +0200 (CEST)
From: axel <axel@rayfun.org>
To: linux-kernel@vger.kernel.org
Subject: NETDEV WATCHDOG eth transmit timed out
Message-ID: <Pine.LNX.4.21.0104181319220.1226-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

on my router which is serving as a gateway for my lan, the adsl connection
is irregularly killed due to the following:
(eth1 is a RTL8139C, kernel 2.4.4pre3, incl. latest rtl8139 driver 0.9.16)


Apr 18 12:11:09 bello kernel: eth1: Setting half-duplex based on
auto-negotiated partner ability 0000.
Apr 18 12:11:27 bello kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr 18 12:11:27 bello kernel: eth1: Tx queue start entry 69  dirty entry
65.
Apr 18 12:11:27 bello kernel: eth1:  Tx descriptor 0 is 00002000.
Apr 18 12:11:27 bello kernel: eth1:  Tx descriptor 1 is 00002000. (queue
head)
Apr 18 12:11:27 bello kernel: eth1:  Tx descriptor 2 is 00002000.
Apr 18 12:11:27 bello kernel: eth1:  Tx descriptor 3 is 00002000.
Apr 18 12:11:27 bello kernel: eth1: Setting half-duplex based on
auto-negotiated partner ability 0000.
Apr 18 12:17:33 bello kernel: eth1: Setting half-duplex based on
auto-negotiated partner ability 0000.
Apr 18 12:17:51 bello kernel: NETDEV WATCHDOG: eth1: transmit timed out
Apr 18 12:17:51 bello kernel: eth1: Tx queue start entry 93  dirty entry
89.
Apr 18 12:17:51 bello kernel: eth1:  Tx descriptor 0 is 00002000.
Apr 18 12:17:51 bello kernel: eth1:  Tx descriptor 1 is 00002000. (queue
head)
Apr 18 12:17:51 bello kernel: eth1:  Tx descriptor 2 is 00002000.
Apr 18 12:17:51 bello kernel: eth1:  Tx descriptor 3 is 00002000.
Apr 18 12:17:51 bello kernel: eth1: Setting half-duplex based on
auto-negotiated
 partner ability 0000.
Apr 18 12:19:14 bello pppd[26928]: No response to 5 echo-requests
Apr 18 12:19:14 bello pppd[26928]: Serial link appears to be disconnected.
Apr 18 12:19:14 bello ip-down: Restored original /etc/resolv.conf
Apr 18 12:19:20 bello pppd[26928]: Connection terminated.
Apr 18 12:19:20 bello pppd[26928]: Connect time 11.2 minutes.
Apr 18 12:19:20 bello pppd[26928]: Sent 5627 bytes, received 59949 bytes.
Apr 18 12:19:20 bello pppoe[26929]: read (asyncReadFromPPP): Input/output
error
Apr 18 12:19:20 bello pppoe[26929]: Sent PADT
Apr 18 12:19:20 bello pppd[26928]: Exit.
Apr 18 12:19:20 bello adsl-connect: ADSL connection lost; attempting
re-connection.

I have heard from some people who had this problem as well but there had
been no real solution to that. Is there some way to debug this, get deeper
to the origin of the problem?
Any help would be FANTASTIC..

Thank you very much,
Axel Siebenwirth

