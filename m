Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282862AbRLGRtZ>; Fri, 7 Dec 2001 12:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRLGRtG>; Fri, 7 Dec 2001 12:49:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:59141 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282771AbRLGRsb>;
	Fri, 7 Dec 2001 12:48:31 -0500
Subject: Re: horrible disk thorughput on itanium
From: Robert Love <rml@tech9.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200112071740.fB7HeVG16220@vindaloo.ras.ucalgary.ca>
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.ker
	 nel> <9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
	<p73n10v6spi.fsf@amdsim2.suse.de>
	<200112071614.fB7GEQ514356@vindaloo.ras.ucalgary.ca>
	<1007745537.828.15.camel@phantasy> 
	<200112071740.fB7HeVG16220@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 12:48:28 -0500
Message-Id: <1007747309.824.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 12:40, Richard Gooch wrote:

> > The link to the mailing list post from bug-glibc says otherwise,
> > that is the problem.  Using the unlocked version isn't implied by
> > not setting __REENTRANT.
> 
> The bug is in glibc. An application shouldn't need to be changed to
> work around that bug. putc() is a well-known interface, and people
> shouldn't have to code around a change in that interface.

Right.  That's why I referenced a post on bug-glibc and called the issue
a problem.  I'm not defending the heaping mass known as glibc ... it
should be fixed.

	Robert Love

