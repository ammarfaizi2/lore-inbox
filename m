Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277746AbRJRPZy>; Thu, 18 Oct 2001 11:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277750AbRJRPZq>; Thu, 18 Oct 2001 11:25:46 -0400
Received: from [65.96.183.159] ([65.96.183.159]:20228 "HELO rakis.net")
	by vger.kernel.org with SMTP id <S277746AbRJRPZe>;
	Thu, 18 Oct 2001 11:25:34 -0400
Date: Thu, 18 Oct 2001 11:29:57 -0400 (EDT)
From: Greg Boyce <gboyce@rakis.net>
To: linux-kernel@vger.kernel.org
Subject: Input on the Non-GPL Modules
Message-ID: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been following the various mail threads regarding the non-GPL
compatable modules, and I had a bit of feedback on the situation.

Last week someone brought up the the notion that if the kernel was marked
as tainted due to proprietary modules being loaded, that people would just
end up modifying the bug report to remove the tainted mark.  

Alan had responded with:
"Well for the moment Im working on the basis that the problem isnt people
trying to con anyone, its people who don't know better - and thats backed
up by my bug queue."

I agree with this fully.  Most people that would be filing bug reports
fall under one of two catagories.  People who don't realize what the
tainted mark means, or people who realize that the kernel developers won't
be able to help them with the proprietary module loaded.  Therefore there
is no motivation for someone to attempt a con.

However, with the addition of GPL only symbols, you add motivation for
conning.  Not by end users, but by the developers of binary only
modules.  If they export the GPL license symbol, they gain access to
kernel symbols that they may want to use.  Since no code is actually being
stolen, would this kind of trick actually cause a licensing violation?

All in all, I find people to be generally honest.  I don't always have
that sort of trust in corporations though.  Just something to think about.

--

Gregory Boyce

