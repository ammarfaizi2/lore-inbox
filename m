Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWHNPfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWHNPfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHNPfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:35:17 -0400
Received: from thunk.org ([69.25.196.29]:62875 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751210AbWHNPfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:35:16 -0400
Date: Mon, 14 Aug 2006 11:34:59 -0400
From: Theodore Tso <tytso@mit.edu>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Message-ID: <20060814153459.GA12298@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Molle Bestefich <molle.bestefich@gmail.com>,
	linux-kernel@vger.kernel.org
References: <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com> <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com> <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com> <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com> <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com> <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com> <20060812163834.GA11497@thunk.org> <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com> <20060812214719.GA19156@thunk.org> <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b0912f0608131221n1657905p327b7ece6d06d20d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 09:21:24PM +0200, Molle Bestefich wrote:
> I'd love to help others with the same problem that I have.  I know
> basically nothing of e2fsck though, and I don't have time to research
> and write a whole tutorial.  Maybe there's a wiki somewhere where I
> can start something out with a structure and some information
> regarding the stuff I've seen?

There isn't yet, but kernel.org is supposed to be setting a wiki soon.
So hopefully we can get a wiki started there.

> >or willing to chip in to pay for a technical writer, let me know....
> 
> What kind of economic scale where you thinking about?

Well, the Technical Advisory Board of the OSDL (James Bottomly is the
chair, other folks include Greg K-H, Randy Dunlap, and others
including myself) is trying to fund a technical writer, mostly for
kernel documentation, as well as other kernel projects.  OSDL is
mainly set up to solicit monies from companies, but it might be
possible to get something setup so we can accept donations from
individuals.

> >(This is open source, which means if people who have the bad manners
> >to kvetch that volunteers have done all of this free work for them
> >haven't done $FOO will be gently reminded that patches to implement
> >$FOO are always welcome.  :-)
> 
> OTOH, the open source community rigorously PR Linux as an alternative
> to Windows.

Some people do, but not all.  It also depends on what usage model you
are looking at.  If it's kiosks or fixed-function Windows facilities
(i.e., used by travel agengts, receptionists, cash registers), then
Linux would certainly be ready now, and it's probably easier to use
Linux than Windows for those scenarios.  But for the "knowledge
worker" who is a power Windows user who regular exchanges Microsoft
Office files with others and who needs 100% Office compatibility?  Not
hardly!

> While the above attitude is fine by me, you're going to have to expect
> to see some sad faces from Windows users when they create a filesystem
> on a loop device and don't realize that the loop driver destroys
> journaling expectancies and results in all their photos and home
> videos going down the drain, all because nobody implemented a simple
> "warning!" message in the software.

To be fair, there are plenty of other dangerous things that you can do
with Windows that don't have warning messages pop-up.  And using the
loop driver is of a complexity which is higher than what you would
expect of a typical Windows user.  You might as well complain that
Linux doesn't give a warning message when you run some command like
"rm -rf /", or "dd if=/dev/null of=/dev/hda".  I'm sure there are
similar commands (probably involving regedit :-) that are just as
dangerous from the Windows cmd.exe window.....

							- Ted
