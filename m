Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVADDMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVADDMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 22:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVADDMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 22:12:17 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:44192 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261997AbVADDMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 22:12:12 -0500
Date: Tue, 4 Jan 2005 04:12:29 +0100
From: Thomas Graf <tgraf@suug.ch>
To: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104031229.GE26856@postel.suug.ch>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk> <20050104002452.GA8045@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104002452.GA8045@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24
> On Mon, Jan 03, 2005 at 06:59:27PM +0000, Russell King wrote:
> > It is also the model we used until OLS this year - there was a 2.6
> > release about once a month prior to OLS.  Post OLS, it's now once
> > every three months or there abouts, which, IMO is far too long.
> 
> I was thinking more about every week or two (ok, two releases in a day
> like we used to do in the 2.3 days was probably too freequent :-), but
> sure, even going to a once-a-month release cycle would be better than
> the current 3 months between 2.6.x releases.

It definitely satifies many of the impatients but it doesn't solve the
stability problem. Many bugs do not show up on developer machines until
just right after the release (as you pointed out already). rc releases
don't work out as expected due to various reasons, i think one of them
is that rc releases don't get announced on the newstickers, extra work
is required to patch the kernel etc. What about doing a test release
just before releasing the final version. I'm not talking about yet
another 2 weeks period but rather just 2-3 days and at most 2 bk
releases in between. Full tarball must be available to make it as
easy as possible. I'm quite sure there are a lot of willing testers
simply too lazy to take a shot at every single rc release. If things
get really worse and huge fixes are required the final release could
be defered in favour of another rc cycle.
