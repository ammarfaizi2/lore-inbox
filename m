Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTFYVYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTFYVYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:24:19 -0400
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37]:11193 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265091AbTFYVXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:23:13 -0400
Date: Wed, 25 Jun 2003 17:37:24 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
Message-ID: <20030625173724.A9146@newbox.localdomain>
References: <1056493150.2840.17.camel@ori.thedillows.org> <20030624204828.I30001@newbox.localdomain> <87vfuuvc0h.fsf@free.fr> <20030625212007.GV3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030625212007.GV3710@fs.tum.de>; from bunk@fs.tum.de on Wed, Jun 25, 2003 at 11:20:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk on Wed 25/06 23:20 +0200:
> > > There were recent threads about this, and a Bugzilla
> > > bug 829 I think.  Try killing magicdev.
> > 
> > Okay, I'll ask a LKML-newbie question.  Bugzilla says
> > "Linux 2.5 kernel bugs only at this time"...  Does that
> > mean this bug won't be fixed in 2.4, or just that the
> > fix will be written for 2.5 and then backported to 2.4?
> 
> The Bugzilla tracks only 2.5 bugs.
> 
> Whether it will be fixed in 2.4 or a fix will be
> backported to 2.4 is beyond the scope of the Bugzilla (but
> of course Bugzilla does not affect how kernel developers
> write and submit fixes).

it tracks 2.5 but I think the bug is the same; it appears
the relevant code has changed but I think the root issue
probably is the same (ide-scsi reset error handling causing
kernel to crash).  The bug submitter for the original bug
said he gets the same behavior on 2.4, but he didn't yet
respond as to whether killing magicdev fixes his problem.
Maybe they're different problems, but they appear related.
