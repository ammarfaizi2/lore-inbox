Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRAWLOa>; Tue, 23 Jan 2001 06:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRAWLOU>; Tue, 23 Jan 2001 06:14:20 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:37965 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129878AbRAWLOI>; Tue, 23 Jan 2001 06:14:08 -0500
Message-ID: <3A6D676C.2F6D5236@linux.com>
Date: Tue, 23 Jan 2001 11:13:48 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com> <3A6D616F.63EB34A6@linux.com> <20010123125636.I25659@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

> On Tue, Jan 23, 2001 at 10:48:16AM +0000, David Ford wrote:
> > The three cardbus cards are slightly different in numerous ways.  For
> > them they normally fault with an APM event, an eject/insert cycle via
> > software will reset hem and a link down/up won't fix it.  For the PCI
> > cards most times a link down/up cycle will fix them.  It's a 2.4 v.s. 2.2
> > issue, the 2.2 kernels aren't exhibiting this error.
>
>         I see that with my AT2800TX cardbus card as well.
>         (Using Tulip driver, no less.)
>
> > The PCI cards are hard to get into this state, sometimes they'll run
> > millions of packets for months on end before they'll burp.  Sometimes
> > it'll happen three times a night.  The amount of traffic doesn't seem
> > to matter, nor does the type of traffic.
>
>         Sounds like timing issue.

Hmm, should we class these as two similar but different bugs?  I suspect they
are both timing but there is another stimulus operating differently.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
