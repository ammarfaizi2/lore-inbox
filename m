Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTIYTkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTIYTkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:40:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12230
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261463AbTIYTkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:40:01 -0400
Date: Thu, 25 Sep 2003 21:41:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OT go to gnu-arch-users for these matters (Re: log-buf-len dynamic)
Message-ID: <20030925194100.GN9953@velociraptor.random>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org> <20030925182233.GA1356@wohnheim.fh-wedel.de> <20030925183623.GC18749@work.bitmover.com> <20030925190222.GA4769@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030925190222.GA4769@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 09:02:22PM +0200, Jörn Engel wrote:
> Actually, you already do that, just with some html around it.  That
> could be stripped off on your side to save bandwidth or I could do it
> myself with a little perl.

I already did that in python, no need to reinvet the wheel :)

It works fine for any project hosted on bkbits but only as far as you've
a reference point to start with (i.e. you've an old tarball) and as far
as there are no merge from cloned trees in the main branch.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/openbkweb/openbkweb-0.0.tar.gz

I'll let it die quickly first because it was using too much bandwidth
according to Larry, and secondly because it couldn't handle merges
across different trees. that's why Larry provided us with the bkcvs
then. But it should still work in theory, though I doubt it can be very
useful if they do merges.

BTW, for obvious reasons I'm posting emails on these matter _only_ on
gnu-arch-users, I already suggested a number of features I need and that
I'd like to add to arch to be usable for my 2.4-aa (for an usage like
b*tkeeper it seems just usable right now but I need more dedicated
features to be able to maintain my tree with a revision control system,
like being able to hook [tag in arch terms] to a unpacked tree with
hardlinks and be able to rollback rejecting patchsets and overwriting
them in new revisions, and automatic conversion from patchsets to an
ordered serie of patches with a meaningful name). All the details here:

	http://mail.gnu.org/mailman/listinfo/gnu-arch-users

thanks,

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
