Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRBJTCD>; Sat, 10 Feb 2001 14:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131687AbRBJTBx>; Sat, 10 Feb 2001 14:01:53 -0500
Received: from ryouko.dgim.crc.ca ([142.92.39.75]:23223 "EHLO
	ryouko.dgim.crc.ca") by vger.kernel.org with ESMTP
	id <S131666AbRBJTBs>; Sat, 10 Feb 2001 14:01:48 -0500
Date: Sat, 10 Feb 2001 14:01:41 -0500 (EST)
From: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>
Reply-To: wmaton@ryouko.dgim.crc.ca
To: linux-kernel@vger.kernel.org
Subject: Interface counter limit?
Message-ID: <Pine.GSO.3.96LJ1.1b7.1010210135854.667B-100000@ryouko.dgim.crc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I've got a linux box here running 2.2.17.  ifconfig reveals this
for eth0:

          RX packets:2147483647 errors:11 dropped:0 overruns:140 frame:22
          TX packets:2147483647 errors:0 dropped:0 overruns:0 carrier:0

Thing is, it's been that way for several weeks.  Is there a counter limit
I'm hitting here with the networking code in the kernel, or is it
ifconfig?  I'm using net-tools-1.55.

Thanks.

wfms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
