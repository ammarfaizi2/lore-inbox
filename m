Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbRAWK5F>; Tue, 23 Jan 2001 05:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbRAWK4v>; Tue, 23 Jan 2001 05:56:51 -0500
Received: from mail.zmailer.org ([194.252.70.162]:65030 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130139AbRAWK4l>;
	Tue, 23 Jan 2001 05:56:41 -0500
Date: Tue, 23 Jan 2001 12:56:36 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Ford <david@linux.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV timeout on tulips [was: Re: 2.4.1-test10]
Message-ID: <20010123125636.I25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com> <3A6CF5B7.57DEDA11@linux.com> <3A6D2D54.619AFA7E@mandrakesoft.com> <3A6D616F.63EB34A6@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A6D616F.63EB34A6@linux.com>; from david@linux.com on Tue, Jan 23, 2001 at 10:48:16AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 10:48:16AM +0000, David Ford wrote:
> The three cardbus cards are slightly different in numerous ways.  For
> them they normally fault with an APM event, an eject/insert cycle via
> software will reset hem and a link down/up won't fix it.  For the PCI
> cards most times a link down/up cycle will fix them.  It's a 2.4 v.s. 2.2
> issue, the 2.2 kernels aren't exhibiting this error.

	I see that with my AT2800TX cardbus card as well.
	(Using Tulip driver, no less.)

> The PCI cards are hard to get into this state, sometimes they'll run
> millions of packets for months on end before they'll burp.  Sometimes
> it'll happen three times a night.  The amount of traffic doesn't seem
> to matter, nor does the type of traffic.

	Sounds like timing issue.

> -d

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
