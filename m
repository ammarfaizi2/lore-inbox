Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLFAKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLFAKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:10:03 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:28545 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S264339AbTLFAIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:08:52 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: David Woodhouse <dwmw2@infradead.org>
To: karim@opersys.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FCED34B.5050309@opersys.com>
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
	 <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
	 <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
	 <3FCED34B.5050309@opersys.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1070669311.8421.35.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7.dwmw2.1) 
Date: Sat, 06 Dec 2003 00:08:31 +0000
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-04 at 01:25 -0500, Karim Yaghmour wrote:
> Since the last time this was mentioned, I have been thinking that this
> argument can really be read as an invitation to do just what's being
> described: first implement a driver/module in a non-Linux OS (this may even
> imply requiring that whoever works on the driver/module have NO Linux
> experience whatsoever; yes there will always be candidates for this) and then
> have this driver/module ported to Linux by Linux-aware developers.

So you have a loadable module made of two sections; a GPL'd wrapper
layer clearly based on the kernel, and your original driver. The latter
is clearly an identifiable section of that compound work which is _not_
derived from Linux and which can reasonably be considered an independent
and separate work in itself.

The GPL and its terms do not apply to that section when you distribute
it as a separate work.

But when you distribute the same section as part of a _whole_ which is a
work based on the Linux kernel, the distribution of the whole must be on
the terms of the licence, whose permissions for other licensees extend
to the entire whole, and thus to each and every part regardless of who
wrote it.

For the precise wording which I've paraphrased above, see §2 of the GPL.
 
Note that 'is this a derived work' is only part of the question you
should be asking yourself. The GPL makes requirements about the
licensing even of works which are _not_ purely derived.

Some claim that copyright law does not allow the GPL to do such a thing.
That is incorrect. I can write a work and license it to you under _any_
terms I see fit. I can, for example, license it to you _only_ on
condition that you agree to release _all_ your future copyrightable
work, including works of fiction and other completely unrelated things,
under terms I decree.

You either do that or you don't have permission to use my work.  Whether
your own work is derived or not is completely irrelevant; if you don't
agree to the terms of _my_ licence, you don't get to use _my_ code.

-- 
dwmw2


