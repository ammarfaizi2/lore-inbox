Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129419AbQKJMFP>; Fri, 10 Nov 2000 07:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbQKJMFF>; Fri, 10 Nov 2000 07:05:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55169 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129419AbQKJMEy>;
	Fri, 10 Nov 2000 07:04:54 -0500
Date: Fri, 10 Nov 2000 03:50:21 -0800
Message-Id: <200011101150.DAA15927@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: davem@redhat.com
CC: ben@zeus.com, linux-kernel@vger.kernel.org
In-Reply-To: <200011101146.DAA15898@pizda.ninka.net> (davem@redhat.com)
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <Pine.LNX.4.30.0011101116580.11412-100000@artemis.cam.zeus.com> <200011101146.DAA15898@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 10 Nov 2000 03:46:02 -0800
   From: "David S. Miller" <davem@redhat.com>

   Wheee... zero timestamp from Cobalt box.  Artemis (correctly) drops
   this packet (due to PAWS test because a zero timestamp is "older" than
   the most recent timestamp Artemis saw from cobalt-box).  Upgrade it's
   kernel and retest :-)

BTW, I bet the platforms which "worked" to this Cobalt box
did not enable TCP timestamps for the connection.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
