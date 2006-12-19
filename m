Return-Path: <linux-kernel-owner+w=401wt.eu-S1752647AbWLSGfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLSGfL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbWLSGfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:35:11 -0500
Received: from 1wt.eu ([62.212.114.60]:1575 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbWLSGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:35:09 -0500
Date: Tue, 19 Dec 2006 07:34:13 +0100
From: Willy Tarreau <w@1wt.eu>
To: "J.H." <warthog9@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061219063413.GI24090@1wt.eu>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166297434.26330.34.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
(...)
> Since it's apparent not everyone is aware of what we are doing, I'll
> mention briefly some of the bigger points.
> 
> - We have contacted HP to see if we can get additional hardware, mind
> you though this is a long term solution and will take time, but if our
> request is approved it will double the number of machines kernel.org
> runs.

Just evil suggestion, but if you contact someone else than HP, they
might be _very_ interested in taking HP's place and providing whatever
you need to get their name on www.kernel.org. Sun and IBM do such
monter machines too. That would not be very kind to HP, but it might
help getting hardware faster.

> - Gitweb is causing us no end of headache, there are (known to me
> anyway) two different things happening on that.  I am looking at Jeff
> Garzik's suggested caching mechanism as a temporary stop-gap, with an
> eye more on doing a rather heavy re-write of gitweb itself to include
> semi-intelligent caching.  I've already started in on the later - and I
> just about have the caching layer put in.  But this is still at least a
> week out before we could even remotely consider deploying it.

Couldn't we disable gitweb for as long as we don't get newer machines ?
I've been using it in the past, but it was just a convenience. If needed,
we can explode all the recent patches with a "git-format-patch -k -m" in a
directory.

> - We've cut back on the number of ftp and rsync users to the machines.
> Basically we are cutting back where we can in an attempt to keep the
> load from spiraling out of control, this helped a bit when we recently
> had to take one of the machines down and instead of loads spiking into
> the 2000+ range we peaked at about 500-600 I believe.

I did not imagine FTP and rsync being so much used !

> So we know the problem is there, and we are working on it - we are
> getting e-mails about it if not daily than every other day or so.  If
> there are suggestions we are willing to hear them - but the general
> feeling with the admins is that we are probably hitting the biggest
> problems already.

BTW, yesterday my 2.4 patches were not published, but I noticed that
they were not even signed not bziped on hera. At first I simply thought
it was related, but right now I have a doubt. Maybe the automatic script
has been temporarily been disabled on hera too ?

> - John 'Warthog9' Hawley
> Kernel.org Admin

Thanks for keeping us informed !
Willy

