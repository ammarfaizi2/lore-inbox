Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTJSEQW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 00:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTJSEQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 00:16:22 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61590 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261889AbTJSEQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 00:16:21 -0400
Date: Sat, 18 Oct 2003 21:15:53 -0700
From: Larry McVoy <lm@bitmover.com>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019041553.GA25372@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	Hans Reiser <reiser@namesys.com>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
	Justin Cormack <justin@street-vision.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Vitaly Fertman <vitaly@namesys.com>,
	Krzysztof Halasa <khc@pm.waw.pl>
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 11:16:42AM +0900, Norman Diamond wrote:
> We need those bad block lists.  They are as necessary as they ever were.

I'm not sure why this is a news flash.  When I was at Sun a 2GB drive
cost us $4000.  I think we sold them for $6000.  You can't buy a 2GB
drive today nor a 20GB drive.  A 200GB drive costs $160.  That's 100
times bigger for 25 times less money, or a net increase of price/capacity
of 2500.  In the same period of time, CPUs have not kept up though they
are close.

You're suprised that drives are unreliable?  Please.  You are getting
unbelievable value from those drives and you demanded it.  Price is the
only way people make purchasing decisions, that's why DEC got out of the
drive business, then HP did, and then IBM did.  They couldn't afford to
compete with the cutrate junk that we call drives today.

I'm not blaming you, I'm as bad as the next guy, I buy based on price
as well but I have no illusions that what I am buying is reliable.
The drives we put into servers here go through a couple weeks of all bit
patterns being changed and even then we don't depend on them, everything
is backed up.

I've told you guys over and over that you need to CRC the data in user
space, we do that in our backup scripts and it tells us when the drives
are going bad.  So we don't get burned and you wouldn't either if you
did the same thing.

Drives are amazingly cheap, it's a miracle that they work at all, don't
be so suprised when they don't.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
