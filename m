Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUJ3X3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUJ3X3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUJ3X3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:29:20 -0400
Received: from [66.35.79.110] ([66.35.79.110]:25756 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261403AbUJ3X3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:29:06 -0400
Date: Sat, 30 Oct 2004 16:28:54 -0700
From: Tim Hockin <thockin@hockin.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041030232854.GA25943@hockin.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 02:13:37AM +0300, Denis Vlasenko wrote:
> > Bloat is cause by feature creep at every layer, not just the app.
> 
> I actually tried to convince maintainers of one package
> that their code is needlessly complex. I did send patches
> to remedy that a bit while fixing real bugs. Rejected.
> Bugs were planned to be fixed by adding more code.
> I've lost all hope on that case.

See, there is an ego problem, too.  If you rewrite my code, it means
you're better than I am.  Rejected.

Features win over efficiency.  Seriously, look at glibc.  Hav eyou ever
tried to fix a bug in it?  Holy CRAP is that horrible code.  Each chunk of
code itself is OK (though it abuses macrso so thoroughly I hesitate to
call it C code).  But it tried to support every architecture x every OS.
You know what?  I don't CARE if the glibc code compiles on HPUX or not.
HPUX has it's own libc.

> I guess this is a reason why bloat problem tend to be solved
> by rewrite from scratch. I could name quite a few cases:

From-scratch is a huge risk.  But yeah, sometimes it has to be.

> It's sort of frightening that someone will need to
> rewrite Xlib or, say, OpenOffice :(

Never gonna happen.
