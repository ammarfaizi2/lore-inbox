Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUJCMfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUJCMfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUJCMfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:35:08 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:57874 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S267876AbUJCMfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:35:01 -0400
Date: Sun, 3 Oct 2004 14:35:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-Id: <20041003143549.12c7fdcc.khali@linux-fr.org>
In-Reply-To: <20041003121645.GA19580@elte.hu>
References: <2Jw9b-52b-13@gated-at.bofh.it>
	<20040929222619.5da3f207.khali@linux-fr.org>
	<20041001184431.4e0c6ba5.akpm@osdl.org>
	<20041002090125.302fff71.khali@linux-fr.org>
	<20041003111458.GA15390@elte.hu>
	<20041003141140.319039de.khali@linux-fr.org>
	<20041003121645.GA19580@elte.hu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now I'm only curious as to why the problem only affected me. Since
> > it looks like noexec is implied on cdrom devices, the problem should
> > have affected everyone. Or are the "!pt_gnu_stack binaries"
> > something rare? I admit I have no idea what it refers to.
> 
> it means you are running an older distro which was built with a gcc
> that doesnt generate PT_GNU_STACK signatures in binaries yet. On the
> biggest distros the transition to PT_GNU_STACK binaries coincided with
> the transition to a 2.6 kernel, so only people who run newer kernels
> on older distros are affected, which is relatively rare since most
> 'older distros' are not 2.6-ready in a number of system-support areas.

OK, I understand now. Both affected systems are running Slackware 9.1,
which may be a bit old (October 2003), but 2.6-ready, so I am using
bleeding edge 2.6 kernels, with no problems (well until a few days ago
;))

> (although the kernel itself of course must be able to run old code
> too.)

Well, I didn't enable any special option as far as I can remember, and
it works just fine :)

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
