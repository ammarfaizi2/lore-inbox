Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRANLAG>; Sun, 14 Jan 2001 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132168AbRANK74>; Sun, 14 Jan 2001 05:59:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54170 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132130AbRANK7m>;
	Sun, 14 Jan 2001 05:59:42 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.34414.185794.396720@pizda.ninka.net>
Date: Sun, 14 Jan 2001 02:58:54 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
In-Reply-To: <20010114124549.D1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net>
	<14945.32886.671619.99921@pizda.ninka.net>
	<20010114124549.D1394@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > Ok. Should I keep reporting new syslog messages as they appear ?

Not the "Undo ***" and "Disorder ***" ones".

But this one is curious:

 > udp v4 hw csum failure.                                                                   
Oh, I think I know why this happens.  Can you add this patch, and next
time the UDP bad csum message appears, tell me if it says "UDP packet
with bad csum was fragmented." in the next line of your syslog
messages?  Thanks.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
