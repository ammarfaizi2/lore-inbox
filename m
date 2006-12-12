Return-Path: <linux-kernel-owner+w=401wt.eu-S932569AbWLLX6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWLLX6K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 18:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWLLX6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 18:58:10 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:59953 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbWLLX6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 18:58:09 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 18:58:09 EST
Date: Wed, 13 Dec 2006 01:50:56 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Postgrey experiment at VGER
Message-ID: <20061212235056.GP10054@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I am running an experiment with Postgrey to delay (for 300 seconds
minimum) incoming emails.   If the clients don't retry after this
delay, then the messages don't usually get in.

The "postgrey" in question is the very same thing that exists for
the Postfix MTA with various automatic whitelistings of repeatedly
successfull senders, etc.

I do already see spammers smart enough to retry addresses from
the zombie machine, but that share is now below 10% of all emails.
My prediction for next 200 days is that most spammers get the clue,
but it gives us perhaps 3 months of less leaked junk.

  /Matti Aarnio -- one of  <postmaster at vger.kernel.org>
