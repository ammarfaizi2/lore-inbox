Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbVKBGFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbVKBGFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVKBGFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:05:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932679AbVKBGFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:05:31 -0500
Date: Tue, 1 Nov 2005 22:05:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <52u0eva8yu.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
 <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
 <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Roland Dreier wrote:
> 
> Anyway, it would be great to find ways to make big improvements.  But
> I think the most realistic way to shrink the kernel is the same way it
> grows in the first place -- one small piece at a time.

No, I think that's a lost cause.

It doesn't grow by 700 bytes once in a while. It grows by much more, and 
much more often. And we can't fight it that way, that's just not going to 
work. Maybe have something that tracks individual object file sizes and 
shames people into not growing them..

		Linus
