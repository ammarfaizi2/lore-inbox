Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWBFNmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWBFNmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWBFNmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:42:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14380 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932100AbWBFNmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:42:00 -0500
Date: Mon, 6 Feb 2006 14:44:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Jeff Mahoney <jeffm@suse.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
Message-ID: <20060206134415.GZ13598@suse.de>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com> <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com> <p73hd7clp5k.fsf@verdi.suse.de> <96DB44F5-85D3-4F78-8417-D5AB9303D696@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96DB44F5-85D3-4F78-8417-D5AB9303D696@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Kyle Moffett wrote:
> On Feb 06, 2006, at 06:09, Andi Kleen wrote:
> >Kyle Moffett <mrmacman_g4@mac.com> writes:
> >>It's a GIT version of an RC patch for grief's sake!  You don't  
> >>seriously expect people to quadruple-check every trivial patch  
> >>that goes into Linus GIT tree before sending it, do you?
> >
> >No quadruple check, but every patch going to Linus should get at  
> >least some basic testing and it's definitely suppose to compile at  
> >least in one .config combination.
> 
> Well, yes, and it did.  The problem was that if you turned off ACLs,  
> it didn't work; only one or two variants of about 6 or 8 ways to  
> configure reiserfs stopped working.  Given that, I can't see how Hans  

Look, it's really simple: lets say I make a change that has to do with
PM, you do a quick compile test with and _without_ PM just to check you
didn't screw anything up with that change. You change reiserfs acl
stuff, you do a quick compile test with and without that configured.

It's a pretty standard procedure, and contrary to what you think, it
_is_ required before submitting a patch. No one is asking anyone to
check all possible configure options, but the interesting data set is
typically extremely easy to guess looking at a change.

-- 
Jens Axboe

