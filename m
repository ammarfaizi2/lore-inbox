Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282919AbRLGRTi>; Fri, 7 Dec 2001 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284090AbRLGRT2>; Fri, 7 Dec 2001 12:19:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:58117 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282919AbRLGRTT>;
	Fri, 7 Dec 2001 12:19:19 -0500
Subject: Re: horrible disk thorughput on itanium
From: Robert Love <rml@tech9.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200112071614.fB7GEQ514356@vindaloo.ras.ucalgary.ca>
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.ker
	 nel> <9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
	<p73n10v6spi.fsf@amdsim2.suse.de> 
	<200112071614.fB7GEQ514356@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 12:18:56 -0500
Message-Id: <1007745537.828.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 11:14, Richard Gooch wrote:

> This kind of thing should be covered by _REENTRANT. If you don't
> compile with _REENTRANT (the default), then putc() should be the
> unlocked version.

The link to the mailing list post from bug-glibc says otherwise, that is
the problem.  Using the unlocked version isn't implied by not setting
__REENTRANT.

	Robert Love

