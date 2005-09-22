Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVIVJcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVIVJcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVIVJcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:32:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60062 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030236AbVIVJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:32:40 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921194306.GC13246@flint.arm.linux.org.uk>
	<43325A02.90208@drzeus.cx>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Sep 2005 03:30:21 -0600
In-Reply-To: <43325A02.90208@drzeus.cx> (Pierre Ossman's message of "Thu, 22
 Sep 2005 09:15:14 +0200")
Message-ID: <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> writes:

> What we probably need then is an official policy that maintainers need
> to have an account in the bugzilla. Start with the subsystem maintainers
> and leave it to them to get each driver maintainer in line. Having only
> a handful of parts of the kernel in the bugzilla is just confusing.

But the definition of a maintainer is whoever takes responsibility for
part X.  The are many pieces of the kernel that don't easily break
up into the taxonomy of subsystem and driver.  There are many people
to reluctantly take responsibility because there is no one else,
and so aren't even mentioned in MAINTAINERS much less the rest of it.

> Personally I think the mailing lists are a great way for general
> discussion. But once we have a confirmed bug (or difficult new feature)
> it is better off being tracked in bugzilla. And this is my opinion both
> as a user and as a developer. Bugzilla is the de facto standard of
> reporting bugs so some users might find it troublesome dealing with
> mailing lists such as LKML.

One problem I have with a system like bugzilla is that frequently bug
reports are not complete, and bugzilla sets the expectation that
once you file a bug the reporters part is complete.  Frequently it takes
several round trips via email to even understand the bug that is being
reported. 

So either we need a two level bug tracking system where there
is a place to capture bugs that users see, and a place to track
bugs that developers understand.  Or we need something that is
much more interactive than bugzilla.

I like Andrews idea of a short term mailing lists for each bug.  Where
filing the bug creates the mailing list and the mailing list exists
until the bug is closed sounds like something that might even get
used, as it can be easy for everyone.

Eric
