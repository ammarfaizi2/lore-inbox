Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272652AbTHELHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272653AbTHELHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:07:08 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:28318
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272652AbTHELHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:07:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 21:12:12 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052056.38861.kernel@kolivas.org> <3F2F8F0E.5060108@cyberone.com.au>
In-Reply-To: <3F2F8F0E.5060108@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052112.12553.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 21:03, Nick Piggin wrote:
> Con Kolivas wrote:
> >Then it takes longer to become interactive. Take 2.6.0-test2 vanilla -
> > audio apps can take up to a minute to be seen as fully interactive;
> > whether this is a problem for your hardware or not is another matter but
> > clearly they are interactive using <1% cpu time on the whole.
>
> I think this is a big problem, a minute is much too long. I guess its
> taking this long to build up because X needs a great deal of inertia
> so that it can stay in a highly interactive state right?
>
> If so then it seems the interactivity estimator does not have enough
> information to work properly for X. In which case maybe X needs to be
> reniced, or backboosted, or have _something_ done to help out.

Well we're in agreement there. That's what all this work I've done is about. 
You'll see I've not been just tweaking numbers.

Con

