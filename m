Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVCCRmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVCCRmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCCRlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:41:09 -0500
Received: from orb.pobox.com ([207.8.226.5]:37353 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262584AbVCCRhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:37:40 -0500
Date: Thu, 3 Mar 2005 10:37:23 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303103723.11cfdd07.dickson@permanentmail.com>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.9.3 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 14:21:38 -0800 (PST), Linus Torvalds wrote:

> The reason I put a shorter timeframe on the "all-even" kernel is because I
> don't want developers to be too itchy and sitting on stuff for too long if
> they did something slightly bigger. In theory, the longer the better
> there, but in practice this release numbering is still nothing but a hint
> of the _intent_ of the developers - it's still not a guarantee of "we
> fixed all bugs", and anybody who expects that (and tries to avoid all odd 
> release entirely) is just setting himself up for not testing - and thus 
> bugs.
> 
> Comments?

You still haven't solved the problem of only a small group using the
development kernels.  Until a "stable" kernel is released, the majority
of kernel compilers will avoid any development kernel (even on this
mailing list!).

Two suggestions (one or both could be implemented):

How about appointing maintainers for 2.6.N kernels, whose responsibility
is apply stability and security patches for 3 months AND until 2.6.N+3 is
released.  So a series of 2.6.11.M kernels will appear until 2.6.14 and
2.6.11 is at least 3 months old.  This would given kernel developers
experience with such releases, but without the job being for the life of
the developer.

Also, add a list to the kernel.org web page about which kernels are
considered stable.  Listed stable kernels are those who have been
released for at least two weeks.

	-Paul

