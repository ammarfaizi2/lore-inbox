Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTETPdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTETPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:33:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263823AbTETPdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:33:42 -0400
Date: Tue, 20 May 2003 08:46:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
In-Reply-To: <20030520105116.A4609@infradead.org>
Message-ID: <Pine.LNX.4.44.0305200842330.3164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Christoph Hellwig wrote:
>
> On Tue, May 20, 2003 at 11:03:36AM +0200, Ingo Molnar wrote:
> > have you all gone nuts??? It's not an option to break perfectly working
> > binaries out there.
> 
> Of course it is. 

NO. 

Christoph, get a grip. Ingo is 100% right.

IT IS NEVER ACCEPTABLE TO BREAK USER LEVEL BINARIES! In particular, we do 
_not_ do it just because of some sense of "aesthetics".

If you want "aesthetics", go play with microkernels, or other academic
projects. They don't care about their users, they care about their ideas. 
The end result is, in my opinion, CRAP.

Linux has never been that way. The _founding_ principle of Linux was
"compatibility". Don't ever forget that. The user comes first. ALWAYS.  
Pretty code is a desirable feature, but if prettifying the code breaks
user apps, it doesn't get prettified.

Repeat after me: the goodness of an operating system is not in how pretty 
it is, but in how well it supports the user.

Make it your mantra.

		Linus

