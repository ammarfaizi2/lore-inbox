Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSDUQ5R>; Sun, 21 Apr 2002 12:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSDUQ5Q>; Sun, 21 Apr 2002 12:57:16 -0400
Received: from bitmover.com ([192.132.92.2]:62362 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313589AbSDUQ5P>;
	Sun, 21 Apr 2002 12:57:15 -0400
Date: Sun, 21 Apr 2002 09:57:15 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [OFF TOPIC] BK license change
Message-ID: <20020421095715.A10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, now seems like a great time to discuss this.  Ha.

It's come to our attention that commercial companies are abusing BK under
the openlogging rules.  To avoid paying for the product, they either put
in no comments or obscure comments.  That is a violation of the license,
but good luck proving that they are doing it on purpose.

The real issue is that we know from past history that companies make 
changes to GPLed software and then delay access to those changes as
long as they can (the GPL allows for a "reasonable" amount of lag,
whatever that is).

The intent of the openlogging requirement was to allow people to work
out in the open on free software, at no charge.  The intent was never 
to allow people to work on free software without giving their changes 
back.  I'm not commenting on people's rights to hide their changes, 
they can do whatever they want, but I *am* saying that we don't have
support closed use for free.

I'm considering a change to the BKL which says that N days after a
changeset is made, that changeset (and its ancestory) must be available
on a public bk server.  In other words, put a hard limit on how long
you may hide.

The time period has to be long enough to cover security fixes, DaveM 
raised that issue.  I'm thinking 90 days.

Note: public server is not limited to bkbits.net.  Any public server is
fine, so long as it is stable, well known, and available ~95% of the time.

I'm well aware that there are a vocal set of people who want complete
freedom to do whatever they want; I don't care to hear from them.  For
the rest of you, would this change be a net positive?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
