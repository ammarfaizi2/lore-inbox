Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTDVLNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDVLNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:13:02 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:29576 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262642AbTDVLNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:13:01 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: BK->CVS, kernel.bkbits.net
Date: 22 Apr 2003 13:09:49 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87adeikcua.fsf@bytesex.org>
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org> <3EA24CF8.5080609@shemesh.biz> <20030420130123.GK2528@phunnypharm.org> <3EA2A285.2070307@shemesh.biz>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1051009789 3170 127.0.0.1 (22 Apr 2003 11:09:49 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shachar Shemesh <lkml@shemesh.biz> writes:

> development environment to build it. Add to that the fact that most
> distros don't carry it as a package (a while back I tried,
> unsuccessfully, to locate an RPM for it, anywhere), and you get
> something that should be deployed with care.

There are rpms for suse 8.1 on ftp.suse.com (i386 only for obvious
reasons).

BTW: With glibc 2.3 the modula-3 compiler bootstrap broke (due to
thread code changes as far I can see, I'm no m3 guru ...), so with
very recent linux distributions you likely have problems to build the
thing even on i386 (unless someone has fixed that in the meantime).
Old cvsup binaries continue to work through.

> On the other hand, both Wine (where I got to know it) and KDE seem to
> offer cvsup for getting the repository, so it can't be THAT
> difficult.

xfree86 + freebsd use it too.

  Gerd

-- 
Michael Moore for president!
