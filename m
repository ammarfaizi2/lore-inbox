Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTJNSol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJNSn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:43:28 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:12743 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262906AbTJNSma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:42:30 -0400
Date: Tue, 14 Oct 2003 11:42:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031014184228.GA16614@ip68-0-152-218.tc.ph.cox.net>
References: <20031013160222.GG3634@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310131904210.4802-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310131904210.4802-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 09:25:44PM +0300, Meelis Roos wrote:
> > > init.c:47:22: mmu_decl.h: No such file or directory
> >
> > That's not right.  Did you do a 'bk -r get -q' or equivalent?  Or is
> > this the rsync version?
> 
> bk -r co -q
> 
> > > Here is my .config for linuxppc-2.4-devel:
> >
> > Works for me.
> 
> Now it works for me too and I could test it.
> 
> linuxppc-2.4-devel too finds only 32M of RAM. 2.4.23-pre7 finds 64M (in
> BAT2).

Now we're getting somewhere.  I believe that 2.4.23-pre7 should have an
option to display all residual data as /proc/residual (or
/proc/residual.gz, I forget).  Can you please enable that, and send me
the data there privately?  Thanks.

> Additionally, I can't seem to interrupt a running program or switch to
> another virtual console in -devel. Normal keys work but ^C and Alt-F*
> are just ignored.

That's very odd.

-- 
Tom Rini
http://gate.crashing.org/~trini/
