Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTJNSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTJNSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:25:57 -0400
Received: from math.ut.ee ([193.40.5.125]:44495 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262721AbTJNSZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:25:55 -0400
Date: Tue, 14 Oct 2003 21:25:44 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031013160222.GG3634@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0310131904210.4802-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > init.c:47:22: mmu_decl.h: No such file or directory
>
> That's not right.  Did you do a 'bk -r get -q' or equivalent?  Or is
> this the rsync version?

bk -r co -q

> > Here is my .config for linuxppc-2.4-devel:
>
> Works for me.

Now it works for me too and I could test it.

linuxppc-2.4-devel too finds only 32M of RAM. 2.4.23-pre7 finds 64M (in
BAT2).

Additionally, I can't seem to interrupt a running program or switch to
another virtual console in -devel. Normal keys work but ^C and Alt-F*
are just ignored.

-- 
Meelis Roos (mroos@linux.ee)


