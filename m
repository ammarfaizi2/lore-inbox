Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSJMNZN>; Sun, 13 Oct 2002 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSJMNZN>; Sun, 13 Oct 2002 09:25:13 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:43736 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261520AbSJMNZN>; Sun, 13 Oct 2002 09:25:13 -0400
Message-ID: <7034136.1034515639605.JavaMail.nobody@web11.us.oracle.com>
Date: Sun, 13 Oct 2002 05:27:19 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.42: IrDA issues
Cc: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PPP over IrDA connection to my Nokia phone; under 2.4.20-preX I have no
 problem keeping the link up, while in 2.5.4x it fails in a very short time like this:

Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
Oct 13 01:13:11 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
Oct 13 01:13:11 dolphin kernel: irda0: transmit timed out
Oct 13 01:13:13 dolphin kernel: IrLAP, no activity on link!
Oct 13 01:13:13 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
Oct 13 01:13:13 dolphin kernel: irda0: transmit timed out
Oct 13 01:13:13 dolphin pppd[5378]: Modem hangup
Oct 13 01:13:13 dolphin pppd[5378]: Connection terminated.
Oct 13 01:13:13 dolphin pppd[5378]: Connect time 1.8 minutes.
Oct 13 01:13:13 dolphin pppd[5378]: Sent 19541 bytes, received 35933 bytes.
Oct 13 01:13:13 dolphin pppd[5378]: Exit.

I also get the transmit timed out spam (why one with WATCHDOG and one without ?)
 in 2.4.20-pre but the IrLAP line isn't there. And the GPRS link stays up...


Thanks in advance for any insight,

--alessandro
