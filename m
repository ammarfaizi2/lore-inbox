Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWATUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWATUBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWATUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:01:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26889 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932119AbWATUBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:01:08 -0500
Date: Fri, 20 Jan 2006 20:00:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Loftis <mloftis@wgops.com>
Cc: Valdis.Kletnieks@vt.edu, dtor_core@ameritech.net,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120200051.GA12610@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Valdis.Kletnieks@vt.edu, dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <43D10FF8.8090805@superbug.co.uk> <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com> <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 12:21:40PM -0700, Michael Loftis wrote:
> I think that it's fine to push the maintenance effort away from the 
> mainline developers, probably even desireable, but then the bugfixing/etc 
> tends to happen in a disparate manner, off on lots of forks at different 
> places without them making their way back to some central place.

The responsibility for ensuring that those bugfixes get back to "some
central place" is with the folk who created the bugfixes.

I've seen this _far_ too many times - it's what I call "the CVS disease"
and it happens _a_ _lot_ in certain areas.

Developer X uses a CVS tree for his work and has write access to that
tree.  He finds a bug, and fixes it.  Maybe he writes a good explaination
of the bug and puts it in the CVS commit comments.  He commits the fix.
When he's done with development, he walks away and the fix never gets
submitted.  (Not everyone operates this way, but I know some do.)


As a mainline guy myself, I'll say we're all welcome to whatever bug
fixes come our way.  We just need someone to send them to us with an
adequate explaination of the bug.

> And that seems where we're going with this conversation.  A fork/forks at 
> various versions to maintain bugfixes and support updates that's (more?) 
> open to submitters writing patches.  Maintained by a separate group or 
> party, but with the 'blessing' from mainline to do so.  A place for those 
> sorts of efforts to be focused, without necessarily involving the primary 
> developers.

Do you know about the bugfix-only kernel series, which have 4-digit
versions - 2.6.x.y - which is the compromise to satisfy folk with the
issue you're bringing up in this paragraph?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
