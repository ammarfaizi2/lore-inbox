Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272647AbTHEKve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272648AbTHEKve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:51:34 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:21406
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272647AbTHEKvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:51:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 20:56:38 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052045.39476.kernel@kolivas.org> <3F2F8B77.4020107@cyberone.com.au>
In-Reply-To: <3F2F8B77.4020107@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052056.38861.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 20:48, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Tue, 5 Aug 2003 20:32, Nick Piggin wrote:
> >>What you are doing is restricting some range so it can adapt more quickly
> >>right? So you still have the problem in the cases where you are not
> >>restricting this range.
> >
> >Avoiding it becoming interactive in the first place is the answer.
> > Anything more rapid and X dies dead as soon as you start moving a window
> > for example, and new apps are seen as cpu hogs during startup and will
> > take _forever_ to start under load. It's a tricky juggling act and I keep
> > throwing more balls at it.
>
> Well, what if you give less boost for sleeping?

Then it takes longer to become interactive. Take 2.6.0-test2 vanilla - audio 
apps can take up to a minute to be seen as fully interactive; whether this is 
a problem for your hardware or not is another matter but clearly they are 
interactive using <1% cpu time on the whole.

Con

