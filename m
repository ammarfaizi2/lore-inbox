Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130292AbRAYVkM>; Thu, 25 Jan 2001 16:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRAYVkC>; Thu, 25 Jan 2001 16:40:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53386 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130292AbRAYVjq>;
	Thu, 25 Jan 2001 16:39:46 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.40164.794066.449539@pizda.ninka.net>
Date: Thu, 25 Jan 2001 13:38:44 -0800 (PST)
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: ionut@cs.columbia.edu (Ion Badulescu), kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, andrewm@uow.EDU.AU (Andrew Morton)
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <200101252129.VAA13948@gw.chygwyn.com>
In-Reply-To: <14960.38705.859136.36297@pizda.ninka.net>
	<200101252129.VAA13948@gw.chygwyn.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve Whitehouse writes:
 > Do you mean that devices will not be able to indicate support of SG seperately
 > from hw checksum or that the IP zerocopy will simply ignore devices which
 > do not have both ?

IP will ignore devices which do not have both.

 > DECnet assumes that the mac level checksum will detect all errors and does
 > not have a checksum of its own on data, so it would only need SG to benefit
 > from the zerocopy framework,

Which is just fine.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
