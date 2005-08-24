Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVHXQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVHXQYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHXQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:24:37 -0400
Received: from web33304.mail.mud.yahoo.com ([68.142.206.119]:9070 "HELO
	web33304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751123AbVHXQYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:24:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EWA6fWkpx06ECrI5S9IX6QQQD1p7klWtHQM27CT2Mr1NzIft4lZfIQGu7Ln1+gOJvQqWjKsfUbWpBAvtGQBglx9RN7YNUkURX2BYZri4oeHBy9etHqNEzT1q91eroLQ+WcTUwQ8y02c/Jyq3Z5afZrDdazkpmcJ9gFUFeOKYD9Y=  ;
Message-ID: <20050824162425.62228.qmail@web33304.mail.mud.yahoo.com>
Date: Wed, 24 Aug 2005 09:24:25 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Patrick McHardy <kaber@trash.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <430B5B14.5070105@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Patrick McHardy <kaber@trash.net> wrote:

> Danial Thom wrote:
> > I think part of the problem is the continued
> > misuse of the word "latency". Latency, in
> > language terms, means "unexplained delay".
> Its
> > wrong here because for one, its explainable.
> But
> > it also depends on your perspective. The
> > "latency" is increased for kernel tasks,
> while it
> > may be reduced for something that is getting
> the
> > benefit of preempting the kernel. So you
> really
> > can't say "the price of reduced latency is
> lower
> > throughput", because thats simply backwards.
> > You've increased the kernel tasks latency by
> > allowing it to be pre-empted. Reduced latency
> > implies higher efficiency. All you've done
> here
> > is shift the latency from one task to
> another, so
> > there is no reduction overall, in fact there
> is
> > probably a marginal increase due to the
> overhead
> > of pre-emption vs doing nothing.
> 
> If instead of complaining you would provide the
> information
> I've asked for two days ago someone might
> actually be able
> to help you.

Because gaining an understanding of how the
settings work is better than having 30 guys
telling me to tune something that is only going
to make a marginal difference. I didn't ask you
to tell me what was wrong with my setup, only
whether its expected that 2.6 would be less
useful in a UP setup than 2.4, which I think
you've answered. 

D

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
