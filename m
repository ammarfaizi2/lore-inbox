Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbQKAXhX>; Wed, 1 Nov 2000 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131854AbQKAXhN>; Wed, 1 Nov 2000 18:37:13 -0500
Received: from [213.47.128.70] ([213.47.128.70]:44805 "HELO
	chello213047128070.15.vie.surfer.at") by vger.kernel.org with SMTP
	id <S131811AbQKAXhL>; Wed, 1 Nov 2000 18:37:11 -0500
Date: Thu, 2 Nov 2000 01:33:05 +0100
From: Markus Fischer <mfischer@josefine.ben.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Cc: Josefine Staff <staff@josefine.ben.tuwien.ac.at>
Subject: [2.2.17] 3c59x and Transmit list error
Message-ID: <20001102013305.A17809@josefine.ben.tuwien.ac.at>
Reply-To: Josefine Staff <staff@josefine.ben.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Editor: Vim  http://www.vim.org/
X-Url: http://josefine.ben.tuwien.ac.at/~mfischer/
X-Factor: Area 51
X-PGP-Key: 0xC2272BD0 at pgp.ai.mit.edu
X-PGP-Fingerprint: D3B0 DD4F E12B F911 3CE1  C2B5 D674 B445 C227 2BD0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

	For some time now we're observing a very bad [tm] network
problem with our 3Com 3c905B Cyclone card. After booting the
network works just fine, but after a few days ( ranging from five
to 10) really hard network problems occur, rendering the network
accessabilty to zero; only manually restarting the network solves
this problem (from local, of course).

I appended the relevant lines of the logfiles for a more
informative description. Altough the date/time stamps are a bit
old (a few feks) the problem still exists recurrence every few
days now :/

I allready searched the mailing list and I'm aware of scylds [1]
website, but unfortunatly none of this information helped us.

kind regards,
	Markus

[1] http://www.scyld.com/network/vortex.html

-- 
Markus Fischer,  http://josefine.ben.tuwien.ac.at/~mfischer/
EMail:         mfischer@josefine.ben.tuwien.ac.at
PGP Public  Key: http://josefine.ben.tuwien.ac.at/~mfischer/C2272BD0.asc
PGP Fingerprint: D3B0 DD4F E12B F911 3CE1  C2B5 D674 B445 C227 2BD0

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel.msg"

Oct  2 08:42:25 josefine kernel: 3c59x.c:v0.99H 12Jun00 Donald Becker and others http://www.scyld.com/network/vortex.html
Oct  2 08:42:25 josefine kernel: eth0: 3Com 3c905B Cyclone 100baseTx at 0xb800,  00:10:5a:22:c4:60, IRQ 10
Oct  2 08:42:25 josefine kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
Oct  2 08:42:25 josefine kernel:   MII transceiver found at address 24, status 786d.
Oct  2 08:42:25 josefine kernel:   MII transceiver found at address 0, status 786d.
Oct  2 08:42:25 josefine kernel:   Enabling bus-master transmits and whole-frame receives.
[...]
Oct 10 18:24:44 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:26:31 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:26:59 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:30:05 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:32:45 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:32:57 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:33:04 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:33:51 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:33:53 josefine kernel: eth0: Transmit error, Tx status register 82.
[...]
Oct 10 18:55:09 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:55:51 josefine kernel: eth0: Tx Ring full, refusing to send buffer.
Oct 10 18:55:57 josefine kernel: eth0: transmit timed out, tx_status 00 status e000.
Oct 10 18:55:57 josefine kernel:   Flags; bus-master 1, full 1; dirty 18492715 current 18492731.
Oct 10 18:55:57 josefine kernel:   Transmit list 00000000 vs. cf98bab0.
Oct 10 18:55:57 josefine kernel:   0: @cf98ba00  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   1: @cf98ba10  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   2: @cf98ba20  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   3: @cf98ba30  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   4: @cf98ba40  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   5: @cf98ba50  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   6: @cf98ba60  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   7: @cf98ba70  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   8: @cf98ba80  length 800005ea status 000005ea
Oct 10 18:55:57 josefine kernel:   9: @cf98ba90  length 800005ea status 800005ea
Oct 10 18:55:57 josefine kernel:   10: @cf98baa0  length 800005ea status 800005ea
Oct 10 18:55:57 josefine kernel:   11: @cf98bab0  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   12: @cf98bac0  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   13: @cf98bad0  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   14: @cf98bae0  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel:   15: @cf98baf0  length 800005ea status 000105ea
Oct 10 18:55:57 josefine kernel: eth0: Resetting the Tx ring pointer.
Oct 10 18:55:57 josefine kernel: eth0: Transmit error, Tx status register 82.
Oct 10 18:55:57 josefine kernel: eth0: Tx Ring full, refusing to send buffer.
Oct 10 18:56:07 josefine kernel: eth0: transmit timed out, tx_status 00 status e000.
Oct 10 18:56:07 josefine kernel:   Flags; bus-master 1, full 1; dirty 18492761 current 18492777.
Oct 10 18:56:07 josefine kernel:   Transmit list 00000000 vs. cf98ba90.
Oct 10 18:56:07 josefine kernel:   0: @cf98ba00  length 800000a6 status 000100a6
Oct 10 18:56:07 josefine kernel:   1: @cf98ba10  length 80000072 status 00010072
Oct 10 18:56:07 josefine kernel:   2: @cf98ba20  length 80000036 status 00010036
Oct 10 18:56:07 josefine kernel:   3: @cf98ba30  length 80000036 status 00010036
Oct 10 18:56:07 josefine kernel:   4: @cf98ba40  length 800005ea status 000105ea
Oct 10 18:56:07 josefine kernel:   5: @cf98ba50  length 80000036 status 00000036
Oct 10 18:56:07 josefine kernel:   6: @cf98ba60  length 800000a6 status 000000a6
Oct 10 18:56:07 josefine kernel:   7: @cf98ba70  length 80000072 status 80000072
Oct 10 18:56:07 josefine kernel:   8: @cf98ba80  length 80000036 status 80000036
Oct 10 18:56:07 josefine kernel:   9: @cf98ba90  length 800000a6 status 000100a6
Oct 10 18:56:07 josefine kernel:   10: @cf98baa0  length 80000072 status 00010072
Oct 10 18:56:07 josefine kernel:   11: @cf98bab0  length 80000036 status 00010036
Oct 10 18:56:07 josefine kernel:   12: @cf98bac0  length 80000036 status 00010036
Oct 10 18:56:07 josefine kernel:   13: @cf98bad0  length 80000036 status 00010036
Oct 10 18:56:07 josefine kernel:   14: @cf98bae0  length 800005ea status 000105ea
Oct 10 18:56:07 josefine kernel:   15: @cf98baf0  length 80000036 status 00010036
[...]

--jI8keyz6grp/JLjh--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
