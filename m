Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUGXQEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUGXQEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 12:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUGXQEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 12:04:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261184AbUGXQEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 12:04:39 -0400
Date: Sat, 24 Jul 2004 11:24:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: szonyi calin <caszonyi@yahoo.com>, Paul Jackson <pj@sgi.com>,
       Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040724142410.GA3009@dmt.cyclades>
References: <20040723081637.93875.qmail@web52903.mail.yahoo.com> <20040723122127.16468.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723122127.16468.qmail@lwn.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 06:21:27AM -0600, Jonathan Corbet wrote:
> > So now the world is divided in gods (i.e distributions) and we,
> > mere mortals who should pray to the gods to give us a stable
> >  kernel ?
> 
> This seems to be where a lot of the misunderstanding is.  Did anybody
> notice just how divergent the distributors' 2.4 (and prior) kernels were
> from the mainline?  If you wanted a kernel with that level of features
> and stability, you had to get it from them - or apply hundreds of
> patches yourself.
> 
> One of the goals of the process now is to get those distributor patches
> into the mainline quickly.  My expectation is that the mainline kernel
> will be far closer to what the distributors ship than it has been in a
> long time, and the mainline will be more stable for it.  Just the
> opposite of what a lot of people are saying.

Well, back in v2.4 "hot-stop", most of the patches merged into distro's kernels 
were not "trustable" enough to be merged into v2.4 mainline, and I had no capability 
of reviewing them myself and make a good enough judgment of whether they should be included
or not.

Another point I had against merging some of those patches was that most of them were 
targeted at "enterprise" users and benefit almost only them (eg finer-grained locking, etc). 

To resume, I prefered to be more "conservative". 

Of course, fortunately Andrew is much more capable of doing judgements on
"trustability" of patches and so forth.

Obviously its a good thing to try to keep the differences between distro's kernels
and mainline kernels small, and Andrew is targetting that. 
