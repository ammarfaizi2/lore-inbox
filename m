Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTDIUiY (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTDIUiY (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:38:24 -0400
Received: from palrel10.hp.com ([156.153.255.245]:58536 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263786AbTDIUiW (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:38:22 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16020.34678.824488.248372@napali.hpl.hp.com>
Date: Wed, 9 Apr 2003 13:49:58 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bk pull
In-Reply-To: <20030409203836.A9397@infradead.org>
References: <200304091927.h39JRob0010157@napali.hpl.hp.com>
	<20030409203836.A9397@infradead.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 9 Apr 2003 20:38:36 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> Btw, do you have any plans to push the changes outside
  Christoph> from arch/ia64 and include/asm-ia64/ in the ia64 patch to
  Christoph> Linus? It would be really nice if the ia64 port could be
  Christoph> used with an out-of-the-box kernel.

Boy, what a loaded question!

Sure, I too would like it if the kernel would always build
out-of-the-box, but I don't think it's very realistic.  Even if I
followed Linus's checkins on an hourly basis (no way in hell I'm ever
gonna do that), there is always a chance that he'll accept a patch
that will (perhaps subtly) break non-x86 platforms.

Having said that, I do submit patches to the respective maintainers
quite frequently.  I probably should cc linux-kernel more often so
others can see that.  Anyhow, I think part of the problem is that I'm
simply not willing to spend inordinate amounts of time pushing the
patches (no, maintaining a kernel tree is not much fun and most
definitely underappreciated, so I do want to get some real work done
occasionally).  For example, the sound driver patches have been around
forever, have been submitted multiple times, and each time we get a
"yeah, that looks good, let me work on it" and that's the last thing
we hear.

I think the only two biggies right now are the AGP/DRM changes (which
I'm working on) and the virtual mem_map support.  The latter I haven't
pushed at all so far, mostly because I just haven't had the
time/energy/interest to do so.  Also, I'm always optimistic someone
else comes along to help with the work... ;-)

	--david
