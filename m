Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWBIAKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWBIAKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWBIAKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:10:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46532 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422711AbWBIAKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:10:01 -0500
Date: Thu, 9 Feb 2006 01:06:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060209000617.GG2654@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602081733.47134.nigel@suspend2.net> <200602081103.46156.rjw@sisk.pl> <200602082208.56599.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602082208.56599.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wednesday 08 February 2006 20:03, Rafael J. Wysocki wrote:
> > Well, that's probably because I always do my best to be nice and follow 
> the
> > rules that Pavel sets.  I post patches to modify the existing code and 
> not to
> > replace it top-down.  I keep them as compact as reasonably possible
> > and focus on one thing at a time.  I remove the parts that Pavel and 
> other
> > people don't like or I try to modify these parts to be more acceptable.
> > Etc.  This is not _that_ difficult.
> 
> Yeah. I guess those are the differences. Thanks for putting it so clearly.
> Well, we're obviously not getting anywhere while I'm trying to redesign the
> existing code, so I guess I'll just go back to finishing the git tree and
> leave anyone who wants to use it to use it.

At one point you said you'd like to work with us, and earlier in the
threads you stated that porting suspend2 to userland should be easy.

[I do not think that putting suspend2 into git is useful thing to
do. Of course, it is your option; but it seems to me that people
likely to use suspend2 are not the kind of people that use git.]

It would be very helpful if you could install uswsusp, then try to
make suspend2 run in userland on top of uswsusp interface. Not
everything will be possible that way, but it most of features should
be doable that way. I'd hate to code yet another splashscreen code,
for example...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
