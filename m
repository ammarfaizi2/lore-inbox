Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRANKLb>; Sun, 14 Jan 2001 05:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbRANKLU>; Sun, 14 Jan 2001 05:11:20 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:63761 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S130271AbRANKLL>;
	Sun, 14 Jan 2001 05:11:11 -0500
Date: Sun, 14 Jan 2001 12:11:05 +0200
From: Petru Paler <ppetru@ppetru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010114121105.B1394@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get messages in syslog looking like:

Undo loss 192.147.174.183/59953 c2 l0 ss2/65535 p0
Undo loss 63.148.232.53/4423 c2 l0 ss2/2 p0
Undo loss 204.253.105.63/25 c2 l0 ss2/2 p0                                                

This is on a dual UltraSPARC box with a Happy Meal network
card. I don't think either Postfix or tinydns (the main load) are using
sendfile().

The machine is stable so far, but it's been up for only 15 minutes.

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
