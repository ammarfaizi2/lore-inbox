Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbRAKOAy>; Thu, 11 Jan 2001 09:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRAKOAo>; Thu, 11 Jan 2001 09:00:44 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:260 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S129810AbRAKOA3>; Thu, 11 Jan 2001 09:00:29 -0500
From: dth@lin-gen.com (Danny ter Haar)
Subject: Re: Drivers under 2.4
Date: Thu, 11 Jan 2001 14:00:26 +0000 (UTC)
Organization: Linux Generation bv
Message-ID: <93ke9q$jnj$1@voyager.cistron.net>
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <20010111115833.A27971@lin-gen.com> <3A5D9AB1.39F6627C@uow.edu.au> <93k75v$r1u$1@voyager.cistron.net>
Reply-To: dth@lin-gen.com
X-Trace: voyager.cistron.net 979221626 20211 195.64.80.162 (11 Jan 2001 14:00:26 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jan 11 12:45:49 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
>Jan 11 12:46:01 multimedia last message repeated 12 times

hot from the ethernet wire: more info just arrived:


NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, status 07f3, resetting.
 Ring data dump: dirty_tx 0 cur_tx 16 (full) cur_rx 0.
  03b2f012 0608 00000040 0310 03b2f812 0608 00000040 0310
  03b2e012 0608 00000040 0310 03b2e812 0608 00000040 0310
  03b2d012 0608 00000040 0310 03b2d812 0608 00000040 0310
  03b2c012 0608 00000040 0310 03b2c812 0608 00000040 0310
  03b2b012 0608 00000040 0310 03b2b812 0608 00000040 0310
  03b2a012 0608 00000040 0310 03b2a812 0608 00000040 0310
  03b29012 0608 00000040 0310 03b29812 0608 00000040 0310
  03b28012 0608 00000040 0310 03b28812 0608 00000111 0310
  03b3f012 0608 000000fc 0310 03b3f812 0608 0000006a 0310
  03b3e012 0608 00000040 0310 03b3e812 0608 00000040 0310
  03b3d012 0608 00000040 0310 03b3d812 0608 00000040 0310
  03b3c012 0608 00000040 0310 03b3c812 0608 00000040 0310
  03b3a012 0608 00000040 0310 03b3a812 0608 00000040 0310
  03b39012 0608 00000040 0310 03b39812 0608 00000040 0340
  03b38012 0608 00000040 0340 03b38812 0608 00000040 0340
  03b4f012 0608 00000040 0340 03b4f812 0608 00000040 0340
  03f9a782 0066 00000000 0300 03b4e222 002a 00000000 0300
  03b4e2a2 002a 00000000 0300 03b4e322 002a 00000000 0300
  03b4e3a2 002a 00000000 0300 03b4e422 002a 00000000 0300
  03b4e4a2 002a 00000000 0300 03b4e522 002a 00000000 0300
  03b4e5a2 002a 00000000 0300 03b4e622 002a 00000000 0300
  03b4e6a2 002a 00000000 0300 03b4eea2 002a 00000000 0300
  03b4ef22 002a 00000000 0300 03f9a882 007e 00000000 0300
  03f9a982 007e 00000000 0300 03f9aa82 007e 00000000 0300
eth0: pcnet32_start_xmit() called, csr0 05f3.
eth0: pcnet32_start_xmit() called, csr0 07f3.                                                                   

etc...

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
