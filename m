Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTD1H3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 03:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbTD1H3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 03:29:10 -0400
Received: from h243n1fls32o865.telia.com ([213.65.113.243]:32388 "EHLO
	h224n1fls32o865.telia.com") by vger.kernel.org with ESMTP
	id S261362AbTD1H3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 03:29:09 -0400
To: Mark Grosberg <mark@nolab.conman.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
X-Face: $$CzX_6%|HNr.oB"KTJp(4s)x@#{7`R#=qth)@YQVIW3G_vqiReP):T3il:o9H[)hjgs%QU
 z!Gx^:NL=B(KNK[Y7{`T*hok`uv`}ArWqZ\wF&KHgVYr+d\>oGI?I\60y?,j*xB@gkYk_)YU0]6"S`
 nEjNqCC
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
From: Mirar <mirar+linuxkernel@mirar.org>
Date: 28 Apr 2003 09:40:42 +0200
In-Reply-To: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org>
Message-ID: <m1llxvax39.fsf@orchid.mirar.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any interest in a single system call that will perform both a
> fork() and exec()? Could this save some extra work of doing a
> copy_mm(), copy_signals(), etc?

I reall have missed it. 

But if you implement one, there are a few extra parameters that can be
nice to have - cwd, uid, gid. I can probably figure out other things
you usually do between fork and exec (chroot, setsid, maybe?).

/Mirar
