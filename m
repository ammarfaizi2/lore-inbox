Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVIUTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVIUTnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVIUTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:43:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751404AbVIUTnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:43:33 -0400
Date: Wed, 21 Sep 2005 20:43:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexander Nyberg <alexn@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com,
       Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net,
       ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <20050921194306.GC13246@flint.arm.linux.org.uk>
Mail-Followup-To: Alexander Nyberg <alexn@telia.com>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
	Andrew Morton <akpm@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, len.brown@intel.com,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
	Masoud Sharbiani <masouds@masoud.ir>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> <20050921173630.GA2477@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921173630.GA2477@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:36:30PM +0200, Alexander Nyberg wrote:
> Morever bugme.osdl.org is severely underworked (acpi being a noteable
> exception) and Andrew has stepped in alot there too. Alot of bugs
> reported on the mailing list are only followed up by Andrew.

That depends on your point of view.  One of the biggest problems
bugme has is that not enough of the kernel developers are on it.

I originally signed up to bugme to be able to use it as a service
for those folk who want to report a bug against the new code I look
after, but (for me) it's turned into a bug reporting system for all
serial drivers and seemingly its my responsibility to fix them all
(because I can't assign them to anyone else - I don't even know
who else is signed up to bugme to be able to give them away.)

And as a direct result of this, I tend to end up rejecting bug
reports for random serial drivers that I have absolutely no idea
about just because I can't shift them.  I don't like doing this
because it means as a whole we're losing valuable bug reports,
but if I don't take this drastic action, I'd end up with pages
of unprocessable bugs.

So, before trying to get the "underworked" bug system used more,
please try to get more developers signed up to it so that we have
the necessary folk behind the bug system to handle the increased
work load.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
