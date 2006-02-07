Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWBGJdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWBGJdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWBGJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:33:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63106 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932449AbWBGJdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:33:37 -0500
Date: Tue, 7 Feb 2006 10:33:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jim Crilly <jim@why.dont.jablowme.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207093317.GB1742@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139251682.2791.290.camel@mindpipe> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl> <20060207003713.GB31153@voodoo> <20060207004611.GD1575@elf.ucw.cz> <20060207005930.GD31153@voodoo> <1139275143.2041.24.camel@mindpipe> <20060207030129.GA23860@mail> <1139282224.2041.48.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139282224.2041.48.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-02-06 22:17:04, Lee Revell wrote:
> On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > With uswsusp it'll be more flexible in that you'll be able to use any
> > userland process or library to transform the image before storing it, but
> > the suspend and resume processes are going to be a lot more complicated.
> > For instance, how are you going to tell the kernel that you need the
> > uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the rest of
> > userland has been frozen?
> 
> Unless someone at least gives a rough estimate of 1) what % of users
> can't suspend their laptops now and 2) of these, what % are helped by
> suspend2, this thread is just handwaving...

and 3) for what % of users, suspend2 will actually break it (bugs
happen).

Anyway it seems to be something like 1) 90% 2) 1% 3) .5%

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
