Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVIUUME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVIUUME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVIUUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:12:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751411AbVIUUMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:12:02 -0400
Date: Wed, 21 Sep 2005 13:10:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: alexn@telia.com, torvalds@osdl.org, pavel@suse.cz, ebiederm@xmission.com,
       len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921131019.21f20e97.akpm@osdl.org>
In-Reply-To: <20050921194306.GC13246@flint.arm.linux.org.uk>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921194306.GC13246@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> So, before trying to get the "underworked" bug system used more,
>  please try to get more developers signed up to it so that we have
>  the necessary folk behind the bug system to handle the increased
>  work load.

They don't actually need to be signed up to bugzilla.  Just cc
bugme-daemon@kernel-bugs.osdl.org on the email trail and anything with
'[Bug NNNN]' in Subject: gets filed appropriately.

So all you need to do forward the email to the relevant culprit and cc
bugme-daemon@kernel-bugs.osdl.org.  Unfotunately some of the emails which
bugzilla sends (the [bugme-new] ones) don't actually have
bugme-daemon@kernel-bugs.osdl.org on the To: or Cc: lines, so you need to
add that by hand the first time.

On problem with all this is that once the discussion has gone to email, it
kinda has to stay that way - if someone goes in and updates the bug via the
web interface, those people who were getting the info only via direct email
don't get to see the new info.   Generally that works out OK.

It would be nice if

a) we could add non-bugzilla-account-holders to a bug's cc list and

b) Once bugzilla sees any person either sending or receiving emails or
   web entries, it autoadds that person to the bug's cc list, so they get
   email for all further activity.  Could be a bit irritating, but tough
   luck ;) We need to fix bugs.


