Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWATMBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWATMBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWATMBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:01:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWATMBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:01:32 -0500
Date: Fri, 20 Jan 2006 04:00:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: marc@perkel.com, arjan@infradead.org, mail@earthworm.de,
       linux-kernel@vger.kernel.org
Subject: Re: So - What's going on with Reiser 4?
Message-Id: <20060120040023.310a1ea8.akpm@osdl.org>
In-Reply-To: <1137299139.25801.7.camel@mindpipe>
References: <43C837B6.5070903@perkel.com>
	<1137236892.3014.12.camel@laptopd505.fenrus.org>
	<200601141322.34520.mail@earthworm.de>
	<1137242691.3014.16.camel@laptopd505.fenrus.org>
	<43C99491.3080907@perkel.com>
	<1137293454.19972.6.camel@mindpipe>
	<43C9C042.5090000@perkel.com>
	<1137299139.25801.7.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Arjan was just telling
>  you that it's not up to the kernel developers when reiser4 gets in
>

Well it is a bit.  Current status is that we just don't have anyone who's
sufficiently familar with VFS internals and idioms who has the
time+inclination to sit down and work with the reiserfs developers to get
the thing into a generally-acceptable state.  Progress has been made over
the past 12-28 months, but there's more to do.  It's a huge piece of code
and a lot of work to do this.

I said I'd do this a couple of months ago but of course haven't had time to
scratch myself.

The second hurdle will be Linus's somewhat-hard-to-define rule of thumb for
such merges: we'll only add such a large burden to the tree if there's
vendor pull for it.  Last time I asked around the vendors the response was
fairly tepid, although that was a year ago.

So reiser4 is somewhat in a state of limbo at present.  We need to
generally up the tempo and firm up some plans rather than letting things
drift like this, but I don't see a way in which we can do that.
