Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317720AbSGVQk6>; Mon, 22 Jul 2002 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSGVQk6>; Mon, 22 Jul 2002 12:40:58 -0400
Received: from dsl-213-023-038-020.arcor-ip.net ([213.23.38.20]:14000 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317720AbSGVQk5>;
	Mon, 22 Jul 2002 12:40:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Date: Mon, 22 Jul 2002 18:45:00 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
References: <3D361091.13618.16DC46FB@localhost> <E17Wf0s-0001tS-00@starship> <1027357077.31782.50.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1027357077.31782.50.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17WgIv-0002Yc-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 July 2002 18:57, Alan Cox wrote:
> On Mon, 2002-07-22 at 16:22, Daniel Phillips wrote:developed equivalent
> > Supposing both device-mapper and (the kernel part of) EVMS get into the tree, 
> > there's nothing stopping you from submitting a patch to make EVMS use 
> > device-mapper.  If there's already equivalent code in EVMS, that just makes 
> > the job easier.
> 
> So we end up with twice as much code to debug and lots of
> incompatibilities when people want to switch around.

If that were a problem, Linux would only have one filesystem.

> It would be far
> better if the two sets of userspace code could at least agree on a
> common kernel interface

Oh, absolutely.

> > I'm firmly in the 'we need both' camp.
> 
> If there is something important in only one then that matters. If there
> are important features in each that are not in the other then that
> really proves they should merge the projects

I dunno about that.  There's more of interest in a subsystem than just what
features it has.  Relying only on what I've seen in this thread, it would
seem natural for EVMS to depend on device-mapper - but why is it necessary
to force the issue immediately, beyond hashing out a suitable interface?

-- 
Daniel
