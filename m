Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWJWCHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWJWCHp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJWCHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:07:45 -0400
Received: from thunk.org ([69.25.196.29]:30435 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751166AbWJWCHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:07:44 -0400
Date: Sun, 22 Oct 2006 22:07:32 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linux Portal <linportal@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: First benchmarks of the ext4 file system
Message-ID: <20061023020731.GA486@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linux Portal <linportal@gmail.com>, linux-kernel@vger.kernel.org
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 01:57:36AM +0200, Linux Portal wrote:
> ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
> to extents and delayed allocation. On other tests it is either
> slightly faster or slightly slower. reiser4 comes as a nice surprise,
> winning few benchmarks. Both are very stable, no errors during
> testing.

As Andrew has already pointed out, we don't have delayed allocation
merged in into the -mm tree yet.  If you have the
time/energy/interest, a very useful thing that would very much help
the filesystem developers of all filesystems to do would be to
automated your tesitng enough that you can do these tests on a
frequent basis, both to track regressions caused by changes in other
parts of the kernel, as well we to see what happens as various bits of
functionality get added to the filesystem.  This of course can become
an arbitrarily a huge amount of work, as you add more filesystems and
benchmarks, but it's the sort of thing which is incredibly useful
especially if the hardware is held constant across a large number of
filesystems, workloads/benchmarks, and kernel versions.  

Regards,

						- Ted
