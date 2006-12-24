Return-Path: <linux-kernel-owner+w=401wt.eu-S1751636AbWLXOQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWLXOQg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWLXOQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:16:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4121 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751636AbWLXOQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:16:36 -0500
Date: Sun, 24 Dec 2006 14:16:25 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
Message-ID: <20061224141625.GA4071@ucw.cz>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org> <20061221235732.GA32637@elte.hu> <20061222120422.eb28953b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222120422.eb28953b.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've always felt that it is wrong (or at least misleading) that WARN_ON
> prints "BUG".  It would have been better if it had said "WARNING", and only
> BUG_ON says "BUG".
> 
> But lots of people have now written downstream log-parsing tools which
> might break due to this change, so I'm inclined to go with Ingo's patch,
> and restore the old (il)logic.

People should not be parsing syslog. If they do, they deserve
occassional breakage.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
