Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTA2Bka>; Tue, 28 Jan 2003 20:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTA2Bka>; Tue, 28 Jan 2003 20:40:30 -0500
Received: from sccmmhc02.mchsi.com ([204.127.203.184]:29925 "EHLO
	sccmmhc02.mchsi.com") by vger.kernel.org with ESMTP
	id <S262038AbTA2Bka>; Tue, 28 Jan 2003 20:40:30 -0500
From: Chuck Burns <zex0s@mchsi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre3 and 3com Integrated 3C556B (3c59x module)
Date: Tue, 28 Jan 2003 19:49:45 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301281949.45510.zex0s@mchsi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having recently upgraded my Mandrake 9.0 Laptop to the latest Mandrake cooker 
(9.1beta) it uses the 2.4.21pre3 kernel.  A problem has occured somewhere 
between 2.4.19 and 2.4.21pre3, with regards to the 3c59x driver module.  It 
incorrectly returns the MAC address for my IBM Thinkpad a20m with 3com 
integrated PCI 10/100M ethernet/Modem combo card. (the Nic is a 3com 3c556b, 
which is supported under the 3c59x module)  The 2.4.19 kernel module 
accurately reports the MAC address.

The 2.4.21pre3 MAC address reported for my card is FF:FF:FF:FF:FF:FF,
which, obviously, is incorrect.  I have never submitted a bug report before, 
so I am not quite sure what all information you need.. there is no error 
message associated with this
-- 
Chuck Burns, Jr <zex0s@mchsi.com>
-----------==========-----------
Don't marry for money; you can borrow it cheaper.
		-- Scottish Proverb

