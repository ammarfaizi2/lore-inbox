Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWGGLmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWGGLmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGGLmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:42:37 -0400
Received: from mail.gmx.net ([213.165.64.21]:29596 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932107AbWGGLmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:42:36 -0400
Cc: michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org, axboe@suse.de
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Jul 2006 13:42:35 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060707040749.97f8c1fc.akpm@osdl.org>
Message-ID: <20060707114235.243260@gmx.net>
MIME-Version: 1.0
References: <20060707070703.165520@gmx.net>
 <20060707040749.97f8c1fc.akpm@osdl.org>
Subject: Re: splice/tee bugs?
To: Andrew Morton <akpm@osdl.org>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > c) Occasionally the command line just hangs, producing no output.
> >    In this case I can't kill it with ^C or ^\.  This is a 
> >    hard-to-reproduce behaviour on my (x86) system, but I have 
> >    seen it several times by now.
> 
> aka local DoS.  Please capture sysrq-T output next time.

I don't have sysrq configured in the kernel that I'm testing at 
the moment (I'll build again with sysrq), but have just got 
the error again.  For what it's worth, "ps l" says:

F   UID   PID  PPID PRI  NI    VSZ   RSS WCHAN  STAT TTY        TIME COMMAND
0  1000  7099   630  16   0      0     0 -      D+   pts/30     0:00 [ktee]

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
