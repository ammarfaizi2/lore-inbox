Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVGOVx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVGOVx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVGOVx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:53:26 -0400
Received: from fmr17.intel.com ([134.134.136.16]:43145 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262027AbVGOVw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:52:29 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Dave Airlie <airlied@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Fri, 15 Jul 2005 14:39:22 -0700
User-Agent: KMail/1.5.4
Cc: Chris Friesen <cfriesen@nortel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <9a8748490507141906fb7e5b@mail.gmail.com> <21d7e997050714191666656d5@mail.gmail.com>
In-Reply-To: <21d7e997050714191666656d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151439.22594.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 19:16, Dave Airlie wrote:
> > That, of course, you cannot do. But, you can regression test a lot of
> > other things, and having a default test suite that is constantly being
> > added to and always being run before releases (that test hardware
> > agnostic stuff) could help cut down on the number of regressions in
> > new releases.
> > You can't test everything this way, nor should you, but you can test
> > many things, and adding a bit of formal testing to the release
> > procedure wouldn't be a bad thing IMO.
>
> But if you read peoples complaints about regression they are nearly
> always to do with hardware that used to work not working any more ..
> alps touchpads, sound cards, software suspend.. so these people still
> gain nothing by you regression testing anything so you still get as
> many reports.. the -rc series is meant to provide the testing for the
> release so nothing really big gets through (like can't boot from IDE
> anymore or something like that)....
>

I've seen large labs of lots of different systems used for dedicated testing 
of products I've worked on in the past.  The validation folks held the keys 
to the build and if a change got in that broke on an important OEM's 
hardware, then everything stops until that change is either fixed or backed 
out.

It aint cheap.  In open source we are attempting to simulate this, but we 
don't simulate the control of the validation leads.

> Dave.

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  

