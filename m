Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282782AbRK0EV5>; Mon, 26 Nov 2001 23:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282784AbRK0EVr>; Mon, 26 Nov 2001 23:21:47 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64240
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282782AbRK0EVg>; Mon, 26 Nov 2001 23:21:36 -0500
Date: Mon, 26 Nov 2001 20:21:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Relson <relson@osagesoftware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
Message-ID: <20011126202129.A26219@mikef-linux.matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	David Relson <relson@osagesoftware.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com> <Pine.LNX.3.96.1011126151758.27112G-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011126151758.27112G-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 03:42:29PM -0500, Bill Davidsen wrote:
> NOTE: this might mean that 2.4.18-pre1 would be out before
> 2.4.17 was actually released. That may bother some people.
[snip]
> least until it is in a development series and has been tested. If it were
> up to me I would have opened 2.5 when 2.4.0 was released, and all the VM
> stuff would have happened there. That's just the way I would assure

The new VM was integrated too late, and 2.4 released too early.

I agree with Linus...  You do need a _known_ starting point for the next dev
kernel.  2.4.15 is known.

Also, having a 17-rc and 18-pre (at the same time) would load down Marcello
much more, and I haven't seen anyone else try it.

If 2.4 stayed 2.3 a bit longer, maybe it would've been cought maybe not.
Who knows if Andrea would've written his new VM back then.

What is interesting now is how Rik's VM (patch against 2.4.16) looks now
that it is seperate from the hugeness of the -ac patch.

The point is, if 2.4.0 was more mature, Linus *could* have given it over to
a maintainer sooner and started 2.5.  Instead, we ended up with a quasi
dev/stable kernel, and no dev "idiot if you don't expect corruption" kernel.
During that time there was no *rock* in 2.4 (unless it crashed - which
hasn't happened to me).  More like packed dirt. ;)

MF
