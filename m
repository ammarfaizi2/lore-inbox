Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270942AbRHSXrQ>; Sun, 19 Aug 2001 19:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270933AbRHSXrG>; Sun, 19 Aug 2001 19:47:06 -0400
Received: from waste.org ([209.173.204.2]:27712 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S270947AbRHSXqt>;
	Sun, 19 Aug 2001 19:46:49 -0400
Date: Sun, 19 Aug 2001 18:47:03 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108191124430.740-100000@waste.org>
Message-ID: <Pine.LNX.4.30.0108191845320.740-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Oliver Xymoron wrote:

> My understanding is that net devices are still mixing data into the pool,
> but with an entropy estimate of zero.

..which appears to be wrong.

> If they're not mixing data into the pool at all any more, then that
> seems wrong to me - we should be adding likely sources of entropy as
> well, even if we can't rely on them enough to credit them.

What we really need is an add_untrusted_randomness().

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

