Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWBGAcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBGAcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBGAcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:32:10 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:25030 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S932423AbWBGAcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:32:09 -0500
Message-ID: <20060207113159.nyjixl5eokookcsw@imp.rexursive.com>
Date: Tue, 07 Feb 2006 11:31:59 +1100
From: Bojan Smojver <bojan@rexursive.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Pavel Machek <pavel@ucw.cz>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<1139251682.2791.290.camel@mindpipe>
	<200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl>
In-Reply-To: <200602070051.41448.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:

> This point is valid, but I don't think the users will _have_ _to_ 
> switch to the
> userland suspend.  AFAICT we are going to keep the kernel-based code
> as long as necessary.

Yep, that's what I thought too. Read on...

> We are just going to implement features in the user space that need not be
> implemented in the kernel.  Of course they can be implemented in the
> kernel, and you have shown that clearly, but since they need not be there,
> we should at least try to implement them in the user space and see how this
> works.

Well, given that the kernel suspend is going to be kept for a while, 
wouldn't it be better if it was feature full? How would the users be at 
a disadvantage if they had better kernel based suspend for a while, 
followed by u-beaut-cooks-cleans-and-washes uswsusp? That's the part I 
don't get...

So, to be direct, let me ask:

Why is it so important to keep an inferior implementation of kernel 
based suspend, when a better one and field tested, exists?

-- 
Bojan
