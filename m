Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132397AbQLHRMW>; Fri, 8 Dec 2000 12:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbQLHRMM>; Fri, 8 Dec 2000 12:12:12 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:50182 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132398AbQLHRMG>;
	Fri, 8 Dec 2000 12:12:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012081641.TAA16371@ms2.inr.ac.ru>
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
To: ak@suse.DE (Andi Kleen)
Date: Fri, 8 Dec 2000 19:41:22 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001208165855.A20706@gruyere.muc.suse.de> from "Andi Kleen" at Dec 8, 0 07:15:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Kill it ;) 

Great day! Nobody will cry that information sort of this:

 *   MUST NOT send ICMP errors in reply to:
 *     ICMP errors (OK)
 *     Broadcast/multicast datagrams (OK)
 *     MAC broadcasts (OK)
 *     Non-initial fragments (OK)
 *     Datagram with a source address that isn't a single host. (OK)

is not available, I hope. 8)


BTW what is this? It is just a question, I missed even the moment, when these
things appeared:

/**
 *	kfree_skb - free an sk_buff
 *	@skb: buffer to free
 *
 *	Drop a reference to the buffer and free it if the usage count has
 *	hit zero.
 */

People, who need _literal_ translation from C to English to understand
two lines of code, really exist in the nature? To be honest, I would not ever
understand what is to "drop a reference to the buffer and free it
if the usage count has hit zero" not looking to code. 8)

Seven times:

 *	If this function is called from an interrupt gfp_mask() must be
 *	%GFP_ATOMIC.

Deep thought, of course. Deep enough to be repeated in each place,
where gfp is used. 8)

Well, I am a fossil, of course, and like to read sources printed on paper
and all these pretentions to convert readbale text to hypertext irritate me.
But such deep thoughts eat even more expensive space on screen!

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
