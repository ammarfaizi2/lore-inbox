Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSGYHHs>; Thu, 25 Jul 2002 03:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSGYHHs>; Thu, 25 Jul 2002 03:07:48 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:516
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S318357AbSGYHHs> convert rfc822-to-8bit; Thu, 25 Jul 2002 03:07:48 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: Checksum problem: 2.4.19-pre3 w/ 3COM Card + Wrong card model
Date: Thu, 25 Jul 2002 03:12:04 -0400
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200207250312.04347.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error below comes from enabling ERPOM boot on the network card. When this 
is disabled the Checksum error goes away.

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
02:05.0: 3Com PCI 3c982 Dual Port Server Cyclone at 0xa400. Vers LK1.1.16
 ***INVALID CHECKSUM 002f*** <6>Linux agpgart interface v0.99 (c) Jeff 
Hartmann

This model is the wrong detected card. 

It should be the 3C980C-TXM 10/100

Shawn.
