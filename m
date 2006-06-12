Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWFLOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWFLOwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWFLOwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:52:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15509 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751982AbWFLOwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:52:40 -0400
Message-ID: <448D7FB0.9070604@garzik.org>
Date: Mon, 12 Jun 2006 10:52:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>, matti.aarnio@zmailer.org
CC: rlrevell@joe-job.com, folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
References: <20060610222734.GZ27502@mea-ext.zmailer.org>	<20060611160243.GH20700@vanheusden.com>	<1150048497.14253.140.camel@mindpipe> <20060611.115430.112290058.davem@davemloft.net>
In-Reply-To: <20060611.115430.112290058.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> We definitely need a better spam solution at vger, the reason is that
> the current mechanism (ad-hoc by-hand regexp blocking) creates lots of
> problems.  For one thing, it means that people with names in languages
> other than english get blocked when their emails are quoted in
> postings.  This is because we don't understand a lot of languages, so
> we just regexp block multibyte characters typically assosciated with
> that language in order to block spam written in that language.
> 
> That isn't acceptable in the long term.

Here's another vote against SPF.

FWIW, DomainKeys looks nice.


> To be honest I'm all for some kind of bayesian filter at vger as long
> as the rejected postings go somewhere into a folder I can scan every
> couple of days looking for false positives.

Though this may not be your thing, I've often thought that this sort of 
task would be an -excellent- janitor task.

Create two simple web pages, one that shows the last 24 hours' worth of 
LKML posts, and another one that shows the last 24 hours' worth of spam. 
  Allow any user on the Internet to report an LKML post as spam, or 
alternately, highlight a false positive as not-spam.  (perhaps generate 
one of those wavy-text verify-you-are-a-human graphics)

Then you, as admin, only have to click a button that accepts or rejects 
the submission(s).  If you want to scan it yourself for false positives, 
you just hit the same webpage as everybody else.

That feedback is then fed into the bayesian system, to train it using 
well-known methods.

	Jeff



