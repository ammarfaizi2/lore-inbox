Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272309AbTHDXgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272310AbTHDXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:36:03 -0400
Received: from palrel12.hp.com ([156.153.255.237]:16577 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S272309AbTHDXff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:35:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.60868.750901.704560@napali.hpl.hp.com>
Date: Mon, 4 Aug 2003 16:35:32 -0700
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
In-Reply-To: <16174.59114.386209.649300@wombat.chubb.wattle.id.au>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<16174.59114.386209.649300@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 5 Aug 2003 09:06:18 +1000, Peter Chubb <peter@chubb.wattle.id.au> said:

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

  David> Now that Linus' tree works for ia64, the next question is how
  David> we can keep it that way.  I think it would be useful to have
  David> someone setup a cron job which does daily builds/automated
  David> tests off of Linus tree.  If something breaks, the person doing
  David> this could perhaps come up with a minimal patch which gets
  David> Linus' tree to build again (and submit a patch to the
  David> appropriate maintainer, with cc to the linux-ia64 list).  I
  David> plan on continuing to put out roughly monthly ia64-specific
  David> patches and during those normal cycles, I'd then integrate the
  David> "quick fix up" patches as needed.  Does this sound reasonable?
  David> Anybody want to volunteer for this "Linus watchdog" role?

  Peter> We can do this.  We're tracking Linus's tree anyway for the work we're
  Peter> doing.

Excellent!

  Peter> We'd probably do daily automated builds to check that the kernel
  Peter> still compiles cleanly for HPSIM, DIG, and ZX1, but test only weekly.

Sounds reasonable.  Except doing a boot/halt cycle on the simulator
should be easy to automate, no?  The simulator can actually catch a
surprising number of problems.

  Peter> If you have anyu specific configuration options you think should be
  Peter> included, let us know.

Nothing in particular, though it would be good to cover UP, MP, 16,
and 64KB page sizes (not in all permutations, of course).

Thanks,

	--david
