Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTGHW2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbTGHW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:28:38 -0400
Received: from user-vc8fdp3.biz.mindspring.com ([216.135.183.35]:59399 "EHLO
	mail.nateng.com") by vger.kernel.org with ESMTP id S265417AbTGHW2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:28:36 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: mail.nateng.com
Date: Tue, 8 Jul 2003 15:43:43 -0700 (PDT)
From: Sir Ace <chandler@nateng.com>
X-X-Sender: chandler@jordan.eng.nateng.com
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
In-Reply-To: <20030708212517.GO1030@dbz.icequake.net>
Message-ID: <Pine.LNX.4.53.0307081539080.24018@jordan.eng.nateng.com>
References: <20030708202819.GM1030@dbz.icequake.net> <3F0B2CE6.8060805@nni.com>
 <20030708212517.GO1030@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HP/UX and some other systems, have kernel parameters that can be set for
max number of processes, and or threads.  I'm not a big fan of it myself,
since there are instances where it would appear to be a 'fork attack' but
be legitimate threads or forks.

Not to mention it is just tacky...  A better solution is:

Know thy users, .... and thy baseball bat.

  -- Sir Ace

On Tue, 8 Jul 2003, Ryan Underwood wrote:

>
> Hi,
>
> On Tue, Jul 08, 2003 at 04:43:18PM -0400, jhigdon wrote:
> >
> > Have you tried this on any 2.5.x kernels? Just curious to see what it
> > does, I plan on giving it a go later.
>
> I haven't, but a previous poster indicated that they had (2.5.74) with
> the same results.
>
> I wonder if we could find an upper limit on the number of allowable
> processes that would leave the box in a workable state?  Unfortunately,
> I don't have a spare box to test such things on at the moment. ;)
>
> Thanks,
>
