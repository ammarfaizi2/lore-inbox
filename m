Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131001AbRANKev>; Sun, 14 Jan 2001 05:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRANKem>; Sun, 14 Jan 2001 05:34:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41626 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131001AbRANKea>;
	Sun, 14 Jan 2001 05:34:30 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.32886.671619.99921@pizda.ninka.net>
Date: Sun, 14 Jan 2001 02:33:26 -0800 (PST)
To: Petru Paler <ppetru@ppetru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
In-Reply-To: <20010114121105.B1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > I get messages in syslog looking like:
 > 
 > Undo loss 192.147.174.183/59953 c2 l0 ss2/65535 p0
 > Undo loss 63.148.232.53/4423 c2 l0 ss2/2 p0
 > Undo loss 204.253.105.63/25 c2 l0 ss2/2 p0

These are normal, if they annoy you please change FASTRETRANS_DEBUG
back to "1" in include/net/tcp.h

This is just an increased debugging setting compared to Linus's
tree, the message you see is harmless.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
