Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUGLUXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUGLUXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUGLUXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:23:39 -0400
Received: from mproxy.gmail.com ([216.239.56.250]:59609 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S262605AbUGLUXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:23:02 -0400
Message-ID: <4d8e3fd30407121322615a8a50@mail.gmail.com>
Date: Mon, 12 Jul 2004 22:22:59 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.6.8-rc1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040712163417.GT4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <4d8e3fd3040712023469039826@mail.gmail.com> <20040712154204.GS4701@fs.tum.de> <4d8e3fd304071208566280e89b@mail.gmail.com> <20040712163417.GT4701@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 18:34:17 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
> On Mon, Jul 12, 2004 at 05:56:14PM +0200, Paolo Ciarrocchi wrote:
> >...
> > > OSDL does some tests for any -rc and many other people like me do other
> > > testing. Besides this, most patches already got similar treatment in
> > > -mm. This might not be a base for an ISO 9000 certificate, but it seems
> > > to be sufficietely working for finding most problems before the acttual
> > > release.
> >
> > OSDL does some test for any -rc but the results of these tests don't affect
> > the release process. At least not in an official way.
> 
> The Linux kernel development process isn't that much formalized. But if
> someone finds a serious new problem in a -rc kernel a fix will usually
> go into the next -rc.

I agree.

> Compared to some other open source projects like e.g. Debian the Linux
> kernel has a pretty well-working release process (and the 2.6
> development avoided several mistakes of the 2.4 development).

I agree, again. 

> > > It would be more important if Linus would release one last -rc that will
> > > be released unchanged (except for EXTRAVERSION a few days later to catch
> > > bugs in last minute changes. This might catch more problems like the JFS
> > > compile problem in 2.6.7.
> >
> > Right,
> > and in those days may be OSDL could run the testsuite we are discussing about.
> 
> The way kernel releases currently work IMHO works well with the
> exception that there should be a last -rc that should be released as
> -final a few days later if no problems show up.
> 
> What other actual problems do you currently observe?

I really don't want to say that the process is now not working,
I'm just saying that it could be improved.

I totally agree with you when you say that there should be a last -rc
that should be released as final if no problem show up.
What I'd like to add is that in the few days between the last -rc and the final
there is enough time automatically run a few tests like the ltp suite,
the compile
stats and a few regression test.

If nothing strange show up, both from the comunity and the automatically tests,
the new version is released.

I don't want to reinvent the wheel, I see that all the tools are
already here, most of them are maintained by OSDL, so *may be* we
should formalized a bit more
the release process.

I don't see any disadvantage in doing this.

ciao, 
Paolo

-- 
paoloc.doesntexist.org
