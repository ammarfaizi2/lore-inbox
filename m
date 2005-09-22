Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVIVKy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVIVKy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 06:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVIVKy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 06:54:59 -0400
Received: from [85.8.12.41] ([85.8.12.41]:8323 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030253AbVIVKy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 06:54:59 -0400
Message-ID: <43328D82.5020505@drzeus.cx>
Date: Thu, 22 Sep 2005 12:54:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>	<20050921173630.GA2477@localhost.localdomain>	<20050921194306.GC13246@flint.arm.linux.org.uk>	<43325A02.90208@drzeus.cx> <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>But the definition of a maintainer is whoever takes responsibility for
>part X.  The are many pieces of the kernel that don't easily break
>up into the taxonomy of subsystem and driver.  There are many people
>to reluctantly take responsibility because there is no one else,
>and so aren't even mentioned in MAINTAINERS much less the rest of it.
>
>  
>

Setting up an account for a mailing list and linking unmaintained parts
to it would be a solution to that. Either set up a specific list for
this or use when of the current ones (like LKML). The big problem I see
at the moment is that not all parts of the kernel are represented in the
bugzilla.

>One problem I have with a system like bugzilla is that frequently bug
>reports are not complete, and bugzilla sets the expectation that
>once you file a bug the reporters part is complete.  Frequently it takes
>several round trips via email to even understand the bug that is being
>reported. 
>  
>

I agree that most bug reports are incomplete. But I still think that a
bugzilla is the way to go. We need to educate the users in filing bug
reports no matter which forum is used. Russell's point about having a
wizard would probably help a lot. A bugzilla also gives the option of
marking bugs with NEEDINFO, INVALID and similar, clearly expressing to
the user how the maintainer sees this bug.

>So either we need a two level bug tracking system where there
>is a place to capture bugs that users see, and a place to track
>bugs that developers understand.  Or we need something that is
>much more interactive than bugzilla.
>
>  
>

I think that the categories NEW/ASSIGNED/CONFIRMED suffices. Although
discussions on mailing lists are more natural for the people here I
don't agree that bugzilla is less interactive than lists.

Rgds
Pierre

