Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCAUQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUCAUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:16:52 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:35720 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261421AbUCAUQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:16:45 -0500
Subject: Re: Dropping CONFIG_PM_DISK?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: M?ns Rullg?rd <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040301124610.GA1744@openzaurus.ucw.cz>
References: <1ulUA-33w-3@gated-at.bofh.it>
	 <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>
	 <yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz>
	 <yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz>
	 <yw1xhdx8ani6.fsf@kth.se> <20040301103946.GA9171@atrey.karlin.mff.cuni.cz>
	 <1078135138.3884.19.camel@laptop-linux.wpcb.org.au>
	 <20040301124610.GA1744@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1078164961.4408.25.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Tue, 02 Mar 2004 07:16:02 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive my ignorance, but I don't see how that could be something that
makes suspend2 less stable than the already-merged versions. They have
the same problem (assuming your patch hasn't been merged yet).

Regards,

Nigel

On Tue, 2004-03-02 at 01:46, Pavel Machek wrote:
> Hi!
> 
> > Can you provide specific examples? I can fix bugs if I'm given
> > reproducible issues instead of hand waving :>
> > 
> 
> Try compiling with regparm=3; you are likely to find some
> missing asmlinkages.
> 				Pavel
-- 
My work on Software Suspend was graciously brought to you between
October and January by LinuxFund.org.

