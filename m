Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUHKSxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUHKSxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268175AbUHKSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:53:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:29081 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268166AbUHKSwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:52:44 -0400
Date: Wed, 11 Aug 2004 20:54:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benno <benjl@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building on platforms other than Linux
Message-ID: <20040811185453.GA7217@mars.ravnborg.org>
Mail-Followup-To: Benno <benjl@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20040811091349.GX862@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811091349.GX862@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:13:49PM +1000, Benno wrote:
> Hi,
> 
> I was wondering if there were any, in priniciple, objections
> to making the Linux kernel buildable on different Unix-like 
> platforms?

The userbase for building kernels are only increasing and there
continue to be more focus from the embedded people.
Having experince in this field first-hand tells me that a kernel
that can be build on several paltforms are a good thing.

For kbuild you will at some point start to see patches so at least
the build system does not restrict us to Linux alone.

People on this list usually reply: "shift development to a Linux
based platform". This is for many developers a nice dream,
but they are restricted by coporate rules etc.

So please feed patches to this list with your findings.

> 
> I am currently compiling on MacOSX and this, for the most part was
> fairly straightforward and simple. The biggest gotcha I had was
> that libkconfig is compiled as a shared library, and unfortunately shared
> libraries are done quite different on different systems. Specifically MacOSX
> doesn't support gcc -shared.

Please submit a patch for this and make sure to include Roman Zippel, he
is the maintainer of kconfig.

[I recall RedHat already disables the shared library??]

	Sam
