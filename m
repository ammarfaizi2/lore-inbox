Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRDBJqr>; Mon, 2 Apr 2001 05:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132663AbRDBJq1>; Mon, 2 Apr 2001 05:46:27 -0400
Received: from [213.97.184.209] ([213.97.184.209]:12672 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S132660AbRDBJqU>;
	Mon, 2 Apr 2001 05:46:20 -0400
Date: Mon, 2 Apr 2001 11:45:06 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Strange problems with 2.4.3.
Message-ID: <Pine.LNX.4.21.0104021133500.450-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	After upgrading to 2.4.3 from the AC series I've found several
problems, first that as several people already reported the tmpfs/shmfs
problem. Also AIC7890 and aicasm problems with db (what about an option in
configure to let people specify the version of db they have? I'm using
db-3 and need to include db_185.h and link with -ldb-3). Those problems
are easy fixed, but I found also the following:

	Everytime I transmit or received anything through my 3com 3c905b
ethernet card I get:

eth1: transmit timed out, tx_status 82 status e605.
diagnostics: net 04d8 media 8880 dma 000000ba.
eth1: Interrupt posted but not delivered IRQ blocked by another device?

I have the following:

eth1: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00,  00:10:5a:48:e6:38, IRQ15
  product code 5150 rev 00.12 date 09-18-98
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.

	And finally after some time up the system just hangs up, the time
is between 5 and 12 hours. No console activity, no SysRQ, nothing on the
logs, just hanged up.

	I'm using 2.4.3 on a Dual PII450 Supermicro P6DBU. And the
2.4.2-ac20 was rock solid (8 days up under heavy loading with no problems,
since then I'm having some minor problems with every kernel).

	Regards,

	- german

PS: Please CC to me as I'm not subscribed to the list.
-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

