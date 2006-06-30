Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWF3O4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWF3O4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWF3O4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:56:20 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:53738
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751789AbWF3O4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:56:20 -0400
Date: Fri, 30 Jun 2006 16:58:25 +0200
From: andrea@cpushare.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060630145825.GA10667@opteron.random>
References: <20060629192121.GC19712@stusta.de> <1151628246.22380.58.camel@mindpipe> <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630094753.GA14603@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 11:47:53AM +0200, Ingo Molnar wrote:
> and both are pledged and available to GPL users. [..]

If the GPL offered any protection to my system software I would
consider it too, but the GPL can't protect software that runs behind
the corporate firewall. You know google can change the kernel without
having to release anything back (note that they a few times posted me
patches and fixes, so they at least try to contribute their changes back
to the community, it's in their interest I think, but I'm just saying
they're not _required_ to publish the exact copy of the kernel that runs
on their servers, if I'm wrong then please send me the link where to
download it). So if I would release my software as GPL anybody with a
bigger web farm than I have could install it, throw some million on ads,
and then I could just setup a redirect from my server that points at
theirs because I would have no chance to survive a competitor with
better financing. Make a license that forces them to release the
software behind the firewall like they have to do if they offer it as
download, and I will think about it. And at the moment thinking about it
or trying writing a license like that myself, is just wasted time. I'll
think about these matters only if it will accepted.

And for yours that covers the http optimizations inside the http
accellerator, apache and other open source webservers aren't GPL and if
you only pledged it under the GPL like you suggest above, apache still
is forbidden to use your technique:

	http://appft1.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=5&f=G&l=50&co1=AND&d=PG01&s1=molnar&s2=ingo&OS=molnar+AND+ingo&RS=molnar+AND+ingo

Same goes for sendmail in the mail one, assuming it has something to do
with the mail (I didn't read it all since it's not my field of
interest).

If I've to keep reading these threads about CONFIG_SECCOMP every few
months then set it to N (even if I disagree with that setting). Like
Alan said, what really matters is what distro will choose in their
config, not the default (and I doubt fedora ships with cifs=Y like the
default where only the required stuff is set to Y, please focus on the
big stuff first ;).
