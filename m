Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWJBKDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWJBKDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWJBKDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:03:04 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:37820 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750699AbWJBKDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:03:03 -0400
Date: Mon, 2 Oct 2006 13:03:02 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
Message-ID: <20061002100302.GS16047@mea-ext.zmailer.org>
References: <1159539793.7086.91.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159539793.7086.91.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 10:23:12AM -0400, Lee Revell wrote:
> What ever happened with bogofilter on vger?  The spam problem is
> considerably worse in the past few weeks.

It is globbing (and blocking) lots of spam.
And now it is rarely blocking ham - under 10 cases per week.

Yes, the thing is NOT 100% perfect.
Especially very short spams are prone to leak thru it,
and those hams that do get block do tend to be longish, and
never before seen.  (It all comes from Bayes Statistics.)

However what is now apparent is that we are no longer
adding very much new patterns into Majordomo filter.
Indeed we are taking off old patterns that bite at wrong things.

I do think that Markov Chains combined with Bayes Statistics 
might do a wee bit better.  (Except with very short emails.)
However all that these things are able to do is essentially
grow the key database when spammers are producing new mutated
(mis-spelled) texts by mixing in spaces, punctuations, and even
occasional characters.

For recognizing those pill merchants one needs complex software
to read the site at the URL, and to read texts out of the IMAGES
at the site.  Captcha to get thru spam filters...

The idea of closed lists is ever more appealing.
We do need to do something for the bug-report addresses like
linux-smp@vger.kernel.org -- so that addresses specified for
receiving the bug reports will still receive them.

I can do fairly easily "this address is allowed to post" type
filters at Majordomo - it has a way to specify allowed posters.
Usually it is used to permit list members to post, but it can
also be configured to use other datasets.


> Lee

  /Matti Aarnio
