Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291600AbSBAIB7>; Fri, 1 Feb 2002 03:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291601AbSBAIBt>; Fri, 1 Feb 2002 03:01:49 -0500
Received: from dsl-213-023-043-113.arcor-ip.net ([213.23.43.113]:4009 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291600AbSBAIBm>;
	Fri, 1 Feb 2002 03:01:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Stuart Young <sgy@amc.com.au>
Subject: Re: Wanted: Volunteer to code a Patchbot
Date: Fri, 1 Feb 2002 09:05:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201312205.g0VM54cS001547@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201312205.g0VM54cS001547@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16WYhk-0000V1-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 31, 2002 11:05 pm, Horst von Brand wrote:
> Stuart Young <sgy@amc.com.au> said:
> 
> [...]
> 
> > Possibly, but then it'll reply to the spammer and you'll get bounces left 
> > and right. Perhaps it's a simple case that the patcher submitting will
> > have to have registered the email address before submitting their patch. 
> > Only needs to be done once (not every time a patch is submitted, that's 
> > mad!), and weeds out the noise.
> 
> And then lkml will be swamped with questions as to why the automated patch
> system doesn't work, or it will just not be used at all because it is more
> work than just firing off a patch at lkml.

The plan is to have both open and registered-users-only patchbots.  The 
second kind is the kind to which maintainers themselves submit to, so the 
forwarded stream of patches is guaranteed to come from trustworthy sources.  
Maintainers themselves can configure their own patchbots to be open or closed 
as they see fit.  In essense, neither submitters not maintainers will see any 
change at all in their procedures, except for the address to which they send 
the patch.[1]

There will be a very significant change in the results of this process from 
the submitter's point of view, since everybody will know where to look to see 
what patches have been submitted, to whom, when, why etc.

There are a lot of things we can do with the patches once they're all sitting 
in the patchbot's database, including tracking the state - applied, rejected, 
being revised, etc.  That's for later, the task at hand is simply to clarify 
and streamline the lines of communication between submitters and maintainers.

[1] Submitters *may* chose to fill in a few lines of metadata in their patch 
to specify, for example, a one-line description which is different from the 
email subject, or that they are not interested in confirmation.  Such 
metadata is not required - the patchbots will accept patches in exactly the 
format we are used to.

-- 
Daniel
