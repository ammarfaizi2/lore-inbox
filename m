Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRKXPwt>; Sat, 24 Nov 2001 10:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKXPwj>; Sat, 24 Nov 2001 10:52:39 -0500
Received: from okcforum.org ([207.43.150.207]:8719 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S278665AbRKXPwU>;
	Sat, 24 Nov 2001 10:52:20 -0500
Subject: Ethernet driver problem
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 24 Nov 2001 09:52:16 -0600
Message-Id: <1006617137.21182.0.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this last night on my 3cSOHO100-TX Hurricane card using the 3c59x
driver while running 2.4.15pre6. I was download a whole directory of
rpms, about 50 of them. I got this on dmesg. I ended up with 2 corrupted
files from the download. Never had this problem before. If it matters I
was using gftp 2.0.9pre3-1 and I was my non-root user.

eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 337158(6) current 337158(6)
  Transmit list 00000000 vs. eee9d380.
  0: @eee9d200  length 80000252 status 00010252
  1: @eee9d240  length 80000036 status 00010036
  2: @eee9d280  length 80000042 status 00010042
  3: @eee9d2c0  length 80000036 status 00010036
  4: @eee9d300  length 80000263 status 00010263
  5: @eee9d340  length 80000036 status 80010036
  6: @eee9d380  length 80000042 status 00010042
  7: @eee9d3c0  length 80000036 status 00010036
  8: @eee9d400  length 80000244 status 00010244
  9: @eee9d440  length 80000036 status 00010036
  10: @eee9d480  length 80000042 status 00010042
  11: @eee9d4c0  length 80000036 status 00010036
  12: @eee9d500  length 80000244 status 00010244
  13: @eee9d540  length 80000036 status 00010036
  14: @eee9d580  length 80000042 status 00010042
  15: @eee9d5c0  length 80000036 status 00010036
eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 346818(2) current 346818(2)
  Transmit list 00000000 vs. eee9d280.
  0: @eee9d200  length 80000251 status 00010251
  1: @eee9d240  length 80000036 status 80010036
  2: @eee9d280  length 80000042 status 00010042
  3: @eee9d2c0  length 80000036 status 00010036
  4: @eee9d300  length 80000273 status 00010273
  5: @eee9d340  length 80000036 status 00010036
  6: @eee9d380  length 80000042 status 00010042
  7: @eee9d3c0  length 80000042 status 00010042
  8: @eee9d400  length 80000042 status 00010042
  9: @eee9d440  length 80000042 status 00010042
  10: @eee9d480  length 80000036 status 00010036
  11: @eee9d4c0  length 80000251 status 00010251
  12: @eee9d500  length 80000036 status 00010036
  13: @eee9d540  length 8000004a status 0001004a
  14: @eee9d580  length 80000042 status 00010042
  15: @eee9d5c0  length 80000036 status 00010036
eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 346819(3) current 346819(3)
  Transmit list 00000000 vs. eee9d2c0.
  0: @eee9d200  length 80000251 status 00010251
  1: @eee9d240  length 80000036 status 00010036
  2: @eee9d280  length 80000251 status 80010251
  3: @eee9d2c0  length 80000036 status 00010036
  4: @eee9d300  length 80000273 status 00010273
  5: @eee9d340  length 80000036 status 00010036
  6: @eee9d380  length 80000042 status 00010042
  7: @eee9d3c0  length 80000042 status 00010042
  8: @eee9d400  length 80000042 status 00010042
  9: @eee9d440  length 80000042 status 00010042
  10: @eee9d480  length 80000036 status 00010036
  11: @eee9d4c0  length 80000251 status 00010251
  12: @eee9d500  length 80000036 status 00010036
  13: @eee9d540  length 8000004a status 0001004a
  14: @eee9d580  length 80000042 status 00010042
  15: @eee9d5c0  length 80000036 status 00010036
eth0: Transmit error, Tx status register 82.
Probably a duplex mismatch.  See Documentation/networking/vortex.txt
  Flags; bus-master 1, dirty 346823(7) current 346823(7)
  Transmit list 00000000 vs. eee9d3c0.
  0: @eee9d200  length 80000251 status 00010251
  1: @eee9d240  length 80000036 status 00010036
  2: @eee9d280  length 80000251 status 00010251
  3: @eee9d2c0  length 80000042 status 00010042
  4: @eee9d300  length 80000042 status 00010042
  5: @eee9d340  length 8000004a status 0001004a
  6: @eee9d380  length 80000251 status 80010251
  7: @eee9d3c0  length 80000042 status 00010042
  8: @eee9d400  length 80000042 status 00010042
  9: @eee9d440  length 80000042 status 00010042
  10: @eee9d480  length 80000036 status 00010036
  11: @eee9d4c0  length 80000251 status 00010251
  12: @eee9d500  length 80000036 status 00010036
  13: @eee9d540  length 8000004a status 0001004a
  14: @eee9d580  length 80000042 status 00010042
  15: @eee9d5c0  length 80000036 status 00010036

