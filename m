Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263106AbSJDSIc>; Fri, 4 Oct 2002 14:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263110AbSJDSIc>; Fri, 4 Oct 2002 14:08:32 -0400
Received: from ns.suse.de ([213.95.15.193]:13061 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263106AbSJDSIb>;
	Fri, 4 Oct 2002 14:08:31 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <20021003221525.GA2221@kroah.com.suse.lists.linux.kernel> <20021003222716.GB14919@suse.de.suse.lists.linux.kernel> <1033684027.1247.43.camel@phantasy.suse.lists.linux.kernel> <20021003233504.GA20570@suse.de.suse.lists.linux.kernel> <20021003235022.GA82187@compsoc.man.ac.uk.suse.lists.linux.kernel> <mailman.1033691043.6446.linux-kernel2news@redhat.com.suse.lists.linux.kernel> <200210040403.g9443Vu03329@devserv.devel.redhat.com.suse.lists.linux.kernel> <20021003233221.C31444@openss7.org.suse.lists.linux.kernel> <20021004133657.B17216@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2002 20:14:03 +0200
In-Reply-To: Pete Zaitcev's message of "4 Oct 2002 19:42:59 +0200"
Message-ID: <p73fzvmqdg4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:
> 
> This leaves syscalltrack, which is pretty interesting in general,
> but I think Mulix suffers from CVS mentality a little here.
> He should aim at getting the hooking mechanism into the kernel.
> I do not think his attempts to act remora and make it transparent
> are safe. Anyway, it's a code which needs to mature and sort it
> out with other hooking mechanisms, we already have dozens of them.
> Let the Darwinean process to work here a little, then we'll see.

privateice also needs it. And there is no easy way to fix it like
oprofile, unless you moved it completely into the kernel.

And AFS of course too for afssyscall.

(both are free)

-Andi

