Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWGVNC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWGVNC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 09:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWGVNC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 09:02:28 -0400
Received: from thunk.org ([69.25.196.29]:43934 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751335AbWGVNC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 09:02:27 -0400
Date: Sat, 22 Jul 2006 09:02:19 -0400
From: Theodore Tso <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060722130219.GB7321@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <44C12F0A.1010008@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C12F0A.1010008@namesys.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 01:46:18PM -0600, Hans Reiser wrote:
> Let me ask that one compare and contrast the ext4 integration procedure
> outlined by Ted Tso

"integration procedure" is hardly an accurate description, rather it
is a development procedure that was developed after discussion and
consensus building across LKML and the ext2/3/4 development team.  It
was not the original plan put forth by the ext2 developers, but after
listening to the concerns and suggestions, we did not question the
motives of the people making suggestions; we listened.

> The code isn't even written, benchmarked, or tested yet,

Actually, the first bits that we plan to merge have already been
written and in use by hundreds of clusterfs customers, posted to LKML
for comments (and we don't attack our reviewers, we thank them for
their comments), and in fact they were written about at last year's
OLS complete with benchmarks and graphs.
(http://ext2.sourceforge.net/2005-ols/2005-ols-ext3.html)

> Consider what happened with XFS as the article writer mentions.  I met
> the original XFS team, led by two very senior developers (Jim Grey, and
> another fellow whose name I am blanking on, forgive me, I learned much
> from him in just a few conversations).  

I believe you are referring to Jim Mostek and Steve Lord, and yes,
they were very talented developers and engineers.  I very much enjoyed
talking to them at various filesystem and Linux conferences and
workshops.

> supervision.  What happened?  They got hassled.  Instead of learning
> from them, welcoming into our community two very senior developers who
> knew a lot more than any of us about the topics they chose to speak
> about, they got hassled, they get ignored, they felt rejected, and left
> the Linux community forever, never to return.  

That's hardly what happened.  SGI went through layoffs, and they were
hit.  See:  http://slashdot.org/articles/01/05/26/0743254.shtml

> A reasonable approach would be to say that any
> filesystem marked as experimental can be dropped at any time, so if you
> aren't able to tar and untar the partition it is on when a new kernel
> comes out, you should not use experimental filesystems.  Then most
> distros will not make the experimental FS visible to users who don't
> press three buttons acknowledging that they were warned....  Linspire's
> view is pretty simple, they need to know that Reiser4 will be accepted
> BEFORE they make their distro depend on it.  

You do realize these two statements are completely contradictory,
don't you?  If an experimental filesystem can be dropped at any time,
then Linspire can't depend on it from the point of view of supporting
their users.  If there is a huge user base, then someone is going to
have to maintain it, even if the developer community has moved on to
supporting the next new exciting filesystem thing.  Hence, it is
critical that the resulting filesystem be fully maintainable before it
is integrated.  To put it in your words, it wouldn't be responsible to
the user base to do otherwise.

							- Ted
