Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUGLQea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUGLQea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUGLQea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:34:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3556 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266884AbUGLQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:34:28 -0400
Date: Mon, 12 Jul 2004 18:34:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
Message-ID: <20040712163417.GT4701@fs.tum.de>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <4d8e3fd3040712023469039826@mail.gmail.com> <20040712154204.GS4701@fs.tum.de> <4d8e3fd304071208566280e89b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd304071208566280e89b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 05:56:14PM +0200, Paolo Ciarrocchi wrote:
>...
> > OSDL does some tests for any -rc and many other people like me do other
> > testing. Besides this, most patches already got similar treatment in
> > -mm. This might not be a base for an ISO 9000 certificate, but it seems
> > to be sufficietely working for finding most problems before the acttual
> > release.
> 
> OSDL does some test for any -rc but the results of these tests don't affect
> the release process. At least not in an official way.

The Linux kernel development process isn't that much formalized. But if 
someone finds a serious new problem in a -rc kernel a fix will usually 
go into the next -rc.

Compared to some other open source projects like e.g. Debian the Linux 
kernel has a pretty well-working release process (and the 2.6 
development avoided several mistakes of the 2.4 development).

> > It would be more important if Linus would release one last -rc that will
> > be released unchanged (except for EXTRAVERSION a few days later to catch
> > bugs in last minute changes. This might catch more problems like the JFS
> > compile problem in 2.6.7.
> 
> Right,
> and in those days may be OSDL could run the testsuite we are discussing about.

The way kernel releases currently work IMHO works well with the 
exception that there should be a last -rc that should be released as 
-final a few days later if no problems show up.

What other actual problems do you currently observe?

> ciao, Paolo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

