Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291132AbSBGNO3>; Thu, 7 Feb 2002 08:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291134AbSBGNOT>; Thu, 7 Feb 2002 08:14:19 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:2443 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291132AbSBGNOP>;
	Thu, 7 Feb 2002 08:14:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: How to check the kernel compile options ?
Date: Thu, 7 Feb 2002 14:18:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16YOBB-0002Mx-00@starship.berlin> <20020207041356.GA21694@bluemug.com>
In-Reply-To: <20020207041356.GA21694@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YoRQ-0000aS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 05:13 am, Mike Touloumtzis wrote:
> On Wed, Feb 06, 2002 at 10:15:49AM +0100, Daniel Phillips wrote:
> > On February 5, 2002 11:13 pm, H. Peter Anvin wrote:
> > > Alex Bligh - linux-kernel wrote:
> > > 
> > > > I would be surprised if there is anyone on this list
> > > > who has not lost at some point either the .config, the
> > > > kysms, or something similar associated with at least
> > > > one build they've made.
> > > 
> > > Sure.  And people have lost their root filesystems due to "rm -rf /".
> > > That doesn't mean we build the entire (real) root filesystem into the
> > > kernel.
> > 
> > Well, it seems to be down to you and Arjan aguing that this usability
> > improvement isn't needed, vs quite a few *users* who are complaining about
> > the current state of things, as well they should because it's less good 
than
> > it could be.
> 
> Numeric participation on lkml discussions is not an indication of much.
> If lkml accurately reflected the state of Linux and its userbase, Linux
> would be the most crash-prone, bug-ridden, chaotic environment ever :-).
> 
> There's probably a lot of people (like me) who use distribution tools like
> Debian's kernel-package to build and manage kernel packages.  If you're
> used to using the right packaging tools, it looks kind of silly to stuff
> text files into the kernel in case they're deleted, instead of doing:
> 
> $ dpkg -x kernel-image-2.4.17_1.00.Custom_i386.deb ~/tmp/
> $ cat ~/tmp/boot/config-2.4.17
> 
> The kernel is just a program, and this is a tools problem.  You don't
> see people arguing that cat's documentation should be moved into /bin/cat
> in case administrators misplace "cat.1.gz".

Cat is standard, kernels aren't.  When was the last time you installed a
custom cat?

-- 
Daniel
