Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUDFSUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbUDFSUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:20:53 -0400
Received: from thunk.org ([140.239.227.29]:41165 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263939AbUDFSUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:20:50 -0400
Date: Tue, 6 Apr 2004 14:20:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Vincent C Jones <vcjones@NetworkingUnlimited.com>
Cc: kevin@scrye.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Message-ID: <20040406182042.GA10329@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Vincent C Jones <vcjones@NetworkingUnlimited.com>, kevin@scrye.com,
	linux-kernel@vger.kernel.org
References: <1HjUX-5pa-3@gated-at.bofh.it> <1HnYA-hr-9@gated-at.bofh.it> <1HKVd-1Uf-3@gated-at.bofh.it> <20040406131602.CCED21421B@x23.networkingunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406131602.CCED21421B@x23.networkingunlimited.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:16:02AM -0400, Vincent C Jones wrote:
> Is it my imagination or is there an acute lack of interest in supporting 
> notebook features in 2.6.X? Since the early days of 2.5.X, there have
> been questions raised regarding suspend/resume and related questions of
> critical importance to mobile users. All (at least those associated with
> IBM ThinkPads) have been ignored by developers, with the only responses
> coming from other notebook users expressing similar concerns.
> 
> Is the answer to upgrade to a faster notebook so I can get adequate
> performance using the 2.4 kernel in order to retain the ability to
> quickly and safely suspend / resume while on the road?
> 
> Side note: X23, kernel 2.6.5, SuSE 9.0 with Kraxel fixes. Suspend only
> works while on battery, forgetting to unplug the AC first fails every
> time and intermittently locks up the box.

Well, I've taken the easy way out and simply used ditched ACPI, and
used APM support, which works just fine on IBM Thinkpads.  It would be
nice if ACPI worked, and every so often I put in a day or two worth of
futile frustration trying to improve ACPI support on my T40 laptop,
but with so many things being broken, and my only having limited
number of hours in the day, so it was much easier to simply fall back
ten yards and punt.

This is not a particularly satisfing solution for people who are stuck
with Dell or Sony laptops that don't have APM support, and who only
have ACPI, but this might have something to do with why I know a lot
of kernel developers who use IBM Thinkpads.  :-P

						- Ted

P.S.  Of course, in the interests of fair disclosure, a lot of them
work for IBM, including myself....
