Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVE1KSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVE1KSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVE1KSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:18:20 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:10500 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262512AbVE1KSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:18:17 -0400
Date: Sat, 28 May 2005 03:22:59 -0700
To: Christoph Hellwig <hch@infradead.org>, Bill Huey <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528102259.GA3072@nietzsche.lynx.com>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <20050528065500.GA17005@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528065500.GA17005@infradead.org>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 07:55:00AM +0100, Christoph Hellwig wrote:
> You're on crack as usual, but today you go much too far.  XFS doesn't
> ahave anything to do with you're so Hard RT pipedreams.  The so-called
> 'RT' subvolulme only provides a more determinitistic block allocator.
> GRIO doesn't require any RT guarantees, it's entirely about I/O scheduling
> and has been ported to various operating systems with sane locking semantics.

I actually when I talked to the SGI folks about 5 years ago at Usenix
I got a different story where they really were thinking about hacking
a tasklet to handle some of this IO stuff going. So I'm going to bet
that you're wrong about this based on that conversation.

The combination of this and RT apps that use it require some kind of
RT guarantees. I've had a number of conversation with SGI folks that
have stated this.

And notice your jumpy comments doesn't dillute any of the things I've
pointed out whether you understand it or not.

bill

