Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWFLKgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWFLKgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWFLKgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:36:45 -0400
Received: from canuck.infradead.org ([205.233.218.70]:39629 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751822AbWFLKgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:36:44 -0400
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, Avi Kivity <avi@argo.co.il>,
       Rik van Riel <riel@redhat.com>, Theodore Tso <tytso@mit.edu>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <17549.16182.237312.734481@cse.unsw.edu.au>
References: <Pine.LNX.4.64.0606110952560.29891@cuia.boston.redhat.com>
	 <448C2298.5000409@argo.co.il> <20060612084739.GD11649@merlin.emma.line.org>
	 <17549.16182.237312.734481@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 11:35:52 +0100
Message-Id: <1150108552.8184.30.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 20:17 +1000, Neil Brown wrote:
> If you get a letter from your aunt in Rome, and it is post-marked
> 'Moscow', you might doubt the authenticity.

If my aunt lives in Rome but I get a postcard (or even a letter) from
her in Moscow, are you suggesting I should consign it to the dustbin
unread? That's what the SPF folks seem to want, and it works no better
in your snail mail analogy than it does in real life.

People travel. Mail gets forwarded.

>   If it claims to be from your swiss bank with the same post mark you
> would doubt it even more. 

In the case of mail from my bank, if it _had_ a postmark rather than
being pre-paid I would be suspicious.

The SPF folks would have me refuse mail from claiming to be from the
bank because it's actually delivered by my postman, and he doesn't work
for the bank therefore it must be a "forgery" (using their new
definition of that term).

Meanwhile, in the real world, I don't want to throw away valid mail. And
there are better ways of avoiding fakes, too. 

ObVger: we should probably enable sender verification callouts, if
they're not being done already. There's no justification for accepting
mail from an address which doesn't accept bounces. That would combat
forgery in a much saner manner.

-- 
dwmw2

