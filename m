Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUA0TIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUA0TIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:08:19 -0500
Received: from thunk.org ([140.239.227.29]:24737 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265538AbUA0TIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:08:17 -0500
Date: Tue, 27 Jan 2004 14:08:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
Message-ID: <20040127190813.GC22933@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4010D9C1.50508@portrix.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:22:25AM +0100, Jan Dittmer wrote:
> 
> Okay, I fscked all filesystems in single user mode, thereby fscked up my 
> root filesystem, though I didn't even check it - so I restored it from 
> backup (grub wouldn't even load anymore).

What messages were printed by e2fsck while it was running --- and was
all of the filesystems unmounted, excepted for the root filesystem,
which should have been mounted read-only?

> After 2 days in my freshly setup debian (2.6.1-bk6), same error. But 
> this time at least I know it's because I tried to delete those files in 
> the lost+found directory...

How did you come to that conclusion?

> So, how do I delete these and why did fsck fail? It's pretty annoying to 
> reboot because of this. It would be nice to just being able to 
> remount,rw the partition.

How did fsck fail?  Without a transcript of the fsck output, it's hard
to say exactly what happened here.

An output of dumpe2fs of the filesystem in question would also be useful.  

						- Ted
