Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTBKLCQ>; Tue, 11 Feb 2003 06:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTBKLBt>; Tue, 11 Feb 2003 06:01:49 -0500
Received: from ns.suse.de ([213.95.15.193]:18188 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267713AbTBKLBZ>;
	Tue, 11 Feb 2003 06:01:25 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiling kernel with debug and optimization
References: <20030210111151.31800.qmail@web20418.mail.yahoo.com.suse.lists.linux.kernel> <20030210192324.GA154@elf.ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Feb 2003 12:11:12 +0100
In-Reply-To: Pavel Machek's message of "11 Feb 2003 12:08:05 +0100"
Message-ID: <p73adh3ax7z.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > Does compiling with -g option degrade performance? IMO it should NOT.
> > 
> > If that's true, then why dont we compile kernels with both -g and -O2
> > always? 
> 
> Build with -g takes *a lot* of diskspace, like 1Gig.

With gcc 3.x and its dwarf2 default.

It's a lot smaller when you compile with -gstabs (on i386)
stabs works as well for 32bit, but is much more compact.

-Andi
