Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCPLi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUCPLi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:38:26 -0500
Received: from gprs214-17.eurotel.cz ([160.218.214.17]:6277 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261451AbUCPLiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:38:22 -0500
Date: Tue, 16 Mar 2004 12:37:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Subject: Re: The verdict on the future of suspending to disk?
Message-ID: <20040316113717.GB2282@elf.ucw.cz>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079408330.3403.5.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just wanting clarification; what are we thinking about the future of
> suspend implementations? Let me throw my current
> understanding/suggestion in for starters:

I'd like to know the results, too.

> - Drop PM_DISK?

I do not care which one is dropped as long as only one implementation
remains. Droping PM_DISK is indeed easiest as noone touched it for
half a year.

> - Apply patches making swsusp into suspend2, leaving out freezer changes
> until people are convinced the current solution is insufficient.

Could you prepare some "swsusp2 without freezer" patch, so that we can
see how it looks like? 

> - Pavel keeps maintaining the end result? (I'm happy to maintain it if
> he wants; I'm assuming when I say this he'll still be dealing with S3
> and Patrick will be deal with PM support proper).

I do not think Patrick is going to maintain anything.

If you want to maintain it, you can have it. Big plus if you are able
to deal with Patrick.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
