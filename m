Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTBVKqJ>; Sat, 22 Feb 2003 05:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTBVKqJ>; Sat, 22 Feb 2003 05:46:09 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2052 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S266961AbTBVKqI>; Sat, 22 Feb 2003 05:46:08 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302221056.h1MAuv3v000270@81-2-122-30.bradfords.org.uk>
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
To: davem@redhat.com (David S. Miller)
Date: Sat, 22 Feb 2003 10:56:57 +0000 (GMT)
Cc: warp@mercury.d2dc.net, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <1045874822.25411.3.camel@rth.ninka.net> from "David S. Miller" at Feb 21, 2003 04:47:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What if the first SYN packet, or the response to it is lost, (which is
> > more possible on congested links, which is when ECN would be most
> > useful), and we disable ECN - then we loose out on functionality we
> > could have, and the work around is actually detremental to
> > performance.  Once 99% of internet hosts support ECN, we could be
> > loosing more than we gain.
> 
> How do you know this is the reason for the lost SYN?

We don't.

> What if other things caused the SYN to be dropped by some
> intermediate site?

Then we would be assuming the host didn't support ECN, when in fact,
it may well do.

> All the workarounds for ECN blackholes violate the protocol and
> cause more problems than they solve.

Which is exactly what I what I was providing an example of.

> That is why we refuse to implement them, and this is why the ECN
> RFCs mark the "suggested workarounds" as optional not required to
> implement.

Errr, so we agree then.  Cool.

John.
