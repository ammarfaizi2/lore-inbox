Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAJDtR>; Tue, 9 Jan 2001 22:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAJDtH>; Tue, 9 Jan 2001 22:49:07 -0500
Received: from colorfullife.com ([216.156.138.34]:19723 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129764AbRAJDs5>;
	Tue, 9 Jan 2001 22:48:57 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0: ieee1394: got invalid ack 3 from node 65473 (tcode 4)
Message-ID: <979098522.3a5bdb9aa7a72@ssl.local>
Date: Wed, 10 Jan 2001 04:48:42 +0100 (CET)
From: Wolfgang Spraul <wspraul@q-ag.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 131.99.21.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incompatibility with "Sarotech FHD-352F/U Rev 1.0"

Using an external IDE drive in the Sarotech FireWire enclosure fails, even
though the Sarotech unit works with Win2K and other SBP2 drives work for me
(with Linux).

I'm using 2.4.0 together with sbp2_1394_122300.tar.gz.
ACK code 3 is not even mentioned in ieee1394.h.

I understand that the SBP2 driver is not (yet) included, but it will be shortly.
Also, I guess the same problem applies to raw1394.o together with the Sarotech
enclosure.
Wolfgang
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
