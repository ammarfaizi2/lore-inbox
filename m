Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286144AbRLJKhk>; Mon, 10 Dec 2001 05:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286170AbRLJKhb>; Mon, 10 Dec 2001 05:37:31 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:35594 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286144AbRLJKhP>; Mon, 10 Dec 2001 05:37:15 -0500
Date: Sun, 9 Dec 2001 15:35:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Quinn Harris <quinn@nmt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File copy system call proposal
Message-ID: <20011209153522.A138@toy.ucw.cz>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu>; from quinn@nmt.edu on Fri, Dec 07, 2001 at 08:42:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would like to propose implementing a file copy system call.
> I expect the initial reaction to such a proposal would be "feature
> bloat" but I believe some substantial benefits can be seen possibly
> making it worthwhile, primarily the following:
> 
> Copy on write:

You want cowlink() syscall, not copy() syscall. If they are on different
partitions, let userspace do the job.

> Will many other users benefit from these features?  Will implementing
> them (especially copy on write) cause an excessive addition to the code
> of the kernel?

Hmm, I have almost 20 different copies of kernel on my systems.... Yep it
would save me a *lot* of space.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

