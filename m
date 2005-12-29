Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVL2U3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVL2U3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVL2U3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:29:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750960AbVL2U3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:29:15 -0500
Date: Thu, 29 Dec 2005 15:28:52 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229202852.GE12056@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 09:41:12AM -0800, Linus Torvalds wrote:

 > Comparing it to the kernel is ludicrous. We care about user-space 
 > interfaces to an insane degree. We go to extreme lengths to maintain even 
 > badly designed or unintentional interfaces. Breaking user programs simply 
 > isn't acceptable. We're _not_ like the gcc developers. We know that 
 > people use old binaries for years and years, and that making a new 
 > release doesn't mean that you can just throw that out. You can trust us.

Does this mean you're holding back the 2.6.15 release until we don't
need to update udev to stop X from breaking ?
</tongue-in-cheek>

Seriously, we break things _every_ release. Sometimes in tiny
'doesn't really matter' ways, sometimes in "fuck, my system no
longer works" ways, but the days where we I didn't have to tell
our userspace packagers to rev a half dozen or so packages up to the
latest upstream revisions when I've pushed a rebased kernel are
a distant memory.

		Dave

