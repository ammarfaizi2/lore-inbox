Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUGNTBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUGNTBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUGNTBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:01:42 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:27623 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265127AbUGNTBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:01:32 -0400
Date: Wed, 14 Jul 2004 12:00:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040714190046.GA21187@taniwha.stupidest.org>
References: <20040713203246.GB6614@taniwha.stupidest.org> <E1BkooR-0003OC-Em@a4.complang.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BkooR-0003OC-Em@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 08:49:03PM +0200, Anton Ertl wrote:

> If a free block was last allocated to a file belonging to user U,
> then it may be ok (it's not a security problem) to put the block in
> a file belonging to user U on recovery; if not, then it's certainly
> not ok to put it into such a file without erasing it first.

that's still a big security problem, consider files with restricted
paths all of a sudden appearing or globally visible root-owned files
appearing with old root-only data in them

> I have never seen Emacs lose data from crashing or (more frequently)
> being killed.  Do you have an idea what went wrong in your case and
> how they

no idea, for a while it would segfault when you resized the window and
you would loose everthing, (no crash handler to attempt to save things
i guess)

> Take a look at <http://www.complang.tuwien.ac.at/czezatke/lfs.html>.

apples and oranges

> BTW, the way my current hardware acts up, system crashes are more
> frequent than application crashes, and certainly more frequent than
> applications behaving badly.

you need new hardware or a new system then

this entire thread is dragging on and seems to have become a religious
discussion about how XFS should because various people don't like it's
current behavior despite the way things have worked that way for many
many years

i don't care if people use XFS or not,  there are plenty of
alternatives

