Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268888AbRG0QtT>; Fri, 27 Jul 2001 12:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268891AbRG0QtJ>; Fri, 27 Jul 2001 12:49:09 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:20744 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268888AbRG0Qs6>;
	Fri, 27 Jul 2001 12:48:58 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271648.UAA19038@ms2.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 27 Jul 2001 20:48:54 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010726202939.D22784@athlon.random> from "Andrea Arcangeli" at Jul 26, 1 08:29:39 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> If there are lots of users of netif_rx outside bh or irq context I guess
> this is the simpler way is:

I prefer to grep for netif_rx yet.

> It should be detectable with this debugging code (untested but trivially
> fixable if it doesn't compile):

It is worth to add to official kernel.

Alexey
