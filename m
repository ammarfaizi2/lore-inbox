Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWBYAUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWBYAUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWBYAUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:20:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:32185 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932643AbWBYAUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:20:11 -0500
Date: Fri, 24 Feb 2006 16:20:29 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 3/4] cleanup __exit_signal()
Message-ID: <20060225002029.GI1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43F9E873.808CD086@tv-sign.ru> <20060224180154.GB1735@us.ibm.com> <43FF4CC2.3BEED999@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FF4CC2.3BEED999@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 09:13:22PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Mon, Feb 20, 2006 at 07:04:03PM +0300, Oleg Nesterov wrote:
> > > This patch factors out duplicated code under 'if' branches.
> > > Also, BUG_ON() conversions and whitespace cleanups.
> > 
> > Passed steamroller.  Looks sane to me.
> 
> Oh, thanks!
> 
> I forgot to say it, but I had run steamroller tests too before I
> sent "some tasklist_lock removals" series.

Glad to hear it!

> Do you know any other test which may be useful too?

Matt Wilcox mentioned that a full build of gdb ran some tests that do
a good job of exercising signals.  I have not yet tried this myself
(but am giving it a shot).

Also, my guess is that you ran steamroller on x86 (how many CPUs?).
I ran on ppc64.

						Thanx, Paul
