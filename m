Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVADVVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVADVVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVADVVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:21:47 -0500
Received: from THUNK.ORG ([69.25.196.29]:25255 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262111AbVADVT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:19:29 -0500
Date: Tue, 4 Jan 2005 16:19:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Thomas Graf <tgraf@suug.ch>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104211910.GB7280@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Thomas Graf <tgraf@suug.ch>, Bill Davidsen <davidsen@tmr.com>,
	Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
	Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com,
	aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
	linux-kernel@vger.kernel.org
References: <20050104031229.GE26856@postel.suug.ch> <200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501041534.j04FY9g7008583@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:34:09PM -0300, Horst von Brand wrote:
> Thomas Graf <tgraf@suug.ch> said:
> > * Theodore Ts'o <20050104002452.GA8045@thunk.org> 2005-01-03 19:24
> > > I was thinking more about every week or two (ok, two releases in a day
> > > like we used to do in the 2.3 days was probably too freequent :-), but
> > > sure, even going to a once-a-month release cycle would be better than
> > > the current 3 months between 2.6.x releases.
> 
> > It definitely satifies many of the impatients but it doesn't solve the
> > stability problem. Many bugs do not show up on developer machines until
> > just right after the release (as you pointed out already). rc releases
> > don't work out as expected due to various reasons, i think one of them
> > is that rc releases don't get announced on the newstickers, extra work
> > is required to patch the kernel etc. What about doing a test release
> > just before releasing the final version. I'm not talking about yet
> > another 2 weeks period but rather just 2-3 days and at most 2 bk
> > releases in between.
> 
> And most users will just wait the extra 2 or 3 days before timidly dipping
> in. Doesn't work.

Some will start testing right away, others will wait 2 or 3 days
first.  And that's fine.  Not all 2.6.x kernels will be good; but if
we do releases every 1 or 2 weeks, some of them *will* be good.  The
problem with the -rc releases is that we try to predict in advance
which releases in advance will be stable, and we don't seem to be able
to do a good job of that.  If we do a release every week, my guess is
that at least 1 in 3 releases will turn out to be stable enough for
most purposes.  But we won't know until after 2 or 3 days which
releases will be the good ones.

In practice, that's all the -rc releases are these days anyway (there
are times when a 2.6.x-rcy release is more stable than 2.6.z).  The
problem is that since the -rc releases are called what they are
called, they don't get enough testing.

						- Ted
