Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRAaQFl>; Wed, 31 Jan 2001 11:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130651AbRAaQFc>; Wed, 31 Jan 2001 11:05:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25352 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130162AbRAaQFR>; Wed, 31 Jan 2001 11:05:17 -0500
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
To: Steve@ChyGwyn.com
Date: Wed, 31 Jan 2001 16:04:21 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), ionut@cs.columbia.edu (Ion Badulescu),
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        andrewm@uow.EDU.AU (Andrew Morton)
In-Reply-To: <200101252129.VAA13948@gw.chygwyn.com> from "Steve Whitehouse" at Jan 25, 2001 09:29:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Nzk7-0002ao-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you mean that devices will not be able to indicate support of SG seperately
> from hw checksum or that the IP zerocopy will simply ignore devices which
> do not have both ?
> 
> DECnet assumes that the mac level checksum will detect all errors and does
> not have a checksum of its own on data, so it would only need SG to benefit
> from the zerocopy framework,

Ditto IPX

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
