Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAYVP6>; Thu, 25 Jan 2001 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135465AbRAYVPs>; Thu, 25 Jan 2001 16:15:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41610 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129169AbRAYVPd>;
	Thu, 25 Jan 2001 16:15:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.38705.859136.36297@pizda.ninka.net>
Date: Thu, 25 Jan 2001 13:14:25 -0800 (PST)
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.EDU.AU>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <Pine.LNX.4.30.0101251253300.20615-100000@age.cs.columbia.edu>
In-Reply-To: <14960.36869.977528.642327@pizda.ninka.net>
	<Pine.LNX.4.30.0101251253300.20615-100000@age.cs.columbia.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ion Badulescu writes:
 > I'm just wondering, if a card supports sg but *not* TX csum, is it worth
 > it to make use of sg? eepro100 falls into this category..

No, not worth it for now.  In fact I'm going to mark that combination
(sg without csum) as illegal in the final zerocopy patch I end up
sending to Linus.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
