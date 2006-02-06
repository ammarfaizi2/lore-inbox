Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWBFJHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWBFJHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBFJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:07:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48910 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750815AbWBFJHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:07:00 -0500
Date: Mon, 6 Feb 2006 10:09:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Jeff Mahoney <jeffm@suse.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
Message-ID: <20060206090915.GJ13598@suse.de>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com> <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05 2006, Kyle Moffett wrote:
> On Feb 05, 2006, at 22:15, Hans Reiser wrote:
> >Jeff Mahoney wrote:
> >>Hans Reiser wrote:
> >>>http://bugzilla.kernel.org/show_bug.cgi?id=6016
> >>>          Summary: reiserfs doesn't build with  
> >>>REISERFS_FS_POSIX_ACL=n
> >>>   Kernel Version: v2.6.16-rc2-g5b7b644
> >>
> >>This was a patch from hch, not me. There's already a patch in -mm to
> >>fix it.
> >
> >Please consider adhering to a quality control process.
> 
> It's a GIT version of an RC patch for grief's sake!  You don't  
> seriously expect people to quadruple-check every trivial patch that  
> goes into Linus GIT tree before sending it, do you?  The whole point  
> of the RC is to indicate that only smaller patches should be applied  
> (and this one was for the most part) so that we can do some kind of  
> global-kernel QC.

Eh, but you are expected to do that. If everybody sent in half-assed not
tested patches "just because" it's a pre-rc, things would look bad.
Compile testing is the least time consuming and easiest thing to to
test, so you should at least do that. If nobody did that, no one would
get snapshots tested because they would never compile for anyone.

For developers it's equally annoying. I typically update my tree every
morning and run with that for the various stuff I'm working on, and it
is really annoying to have to spent time on hunting down and fixing
compile errors.

This mail is about the mentality displayed, not the specific change that
spawned it.

-- 
Jens Axboe

