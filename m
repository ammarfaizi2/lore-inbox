Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVIVJib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVIVJib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbVIVJib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:38:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8206 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030240AbVIVJia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:38:30 -0400
Date: Thu, 22 Sep 2005 10:38:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Alexander Nyberg <alexn@telia.com>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <20050922093811.GC16949@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Alexander Nyberg <alexn@telia.com>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
	Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
	acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
	Masoud Sharbiani <masouds@masoud.ir>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com> <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org> <20050921173630.GA2477@localhost.localdomain> <20050921194306.GC13246@flint.arm.linux.org.uk> <43325A02.90208@drzeus.cx> <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14q8dcuvm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:30:21AM -0600, Eric W. Biederman wrote:
> One problem I have with a system like bugzilla is that frequently bug
> reports are not complete, and bugzilla sets the expectation that
> once you file a bug the reporters part is complete.  Frequently it takes
> several round trips via email to even understand the bug that is being
> reported. 

What it needs is something like the Red Hat bugzilla front end,
where reporters are guided through the information they need to
submit.  Maybe that would help with bugme if we had such a front
end?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
