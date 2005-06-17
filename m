Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVFQVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVFQVgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFQVgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:36:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262093AbVFQVdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:33:36 -0400
Date: Fri, 17 Jun 2005 14:33:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>, Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, rml@novell.com, zab@zabbo.net, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patch] inotify.
Message-Id: <20050617143334.41a31707.akpm@osdl.org>
In-Reply-To: <20050617175605.GB1981@tentacle.dhs.org>
References: <1118855899.3949.21.camel@betsy>
	<42B1BC4B.3010804@zabbo.net>
	<1118946334.3949.63.camel@betsy>
	<200506171907.39940.arnd@arndb.de>
	<20050617175605.GB1981@tentacle.dhs.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> This was settled a long time ago. Robert, Andrew, and I had an off-list
> discussion months ago, and we all agreed that this was the right
> interface for inotify.

I don't think I ever really affirmatively agreed to anything.  I do recall
various things being discussed at various times and various things being
changed, but from where I sit it's all spread out and foggy.

I certainly remember that good-sounding recommendations which addressed the
things which Christoph doesn't like were convincingly shot down by yourself
and by Robert, but I don't recall why.

Look, this stuff is hard.  This is why I've asked you and Robert again and
again and again to generate some sort of design doc or FAQ which addresses
each of these frequently-asked-questions.  So the poor rest of us can look
through it and say "oh yeah".  Because inotify _is_ a tricky thing, and
standard kernel interface designs _don't_ fit it well.

So.  It's not too late.  Please spend an hour and write up the Inofity
Implementation FAQ?  You probably remember and fully understand what all of
our objections are and I know that you have explanations and rebuttals at
hand.

Please?  Something like:

q: Why does it use an ioctl multiplexer

a: Because ...

etc...

I haven't done a detailed review of the patch in months and I intend to do
another soon.  That FAQ will help!  When I ask more silly questions we can
update it, so those questions will never again be asked.

I know it's unusual process-wise, but inotify is an unusual feature.
