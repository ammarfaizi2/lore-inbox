Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCCTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCCTs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCCTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:45:51 -0500
Received: from khc.piap.pl ([195.187.100.11]:53764 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261647AbVCCTmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:42:55 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002047.GA10434@kroah.com>
	<Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	<20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com>
	<20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com>
	<20050303021506.137ce222.akpm@osdl.org> <4226EE0F.1050405@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 03 Mar 2005 20:41:02 +0100
In-Reply-To: <4226EE0F.1050405@pobox.com> (Jeff Garzik's message of "Thu, 03
 Mar 2005 05:59:27 -0500")
Message-ID: <m3vf88v7ox.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> 1) There is no clear, CONSISTENT point where "bugfixes only"
> begins. Right now, it could be -rc2, -rc3, -rc4... who knows.
>
> We need to send a clear signal to users "this is when you can really
> start hammering it."  A signal that does not change from release to
> release.  A signal that does not require intimate knowledge of the
> kernel devel process.

I think so.

> 2) After 2.6.11 release is out, there is no established process for
> "oh shit, 2.6.11 users will really want that fixed."

We can do 2.6.11.x scheme. For the last stable kernel, of course
(i.e., one additional small patchset). No more 2.6.11.x when 2.6.12
is out.

> The 2.4.x series -pre/-rc is an example of a solution for problem #1.

Yes.
But, to shorten the time between stable kernels, I would limit
number of "pre"s. Maybe 1 or even no "pre" kernel is enough?
Massive updates would take place before rc1 is released, of course.
-- 
Krzysztof Halasa
