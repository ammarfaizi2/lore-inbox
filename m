Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269319AbUJQUjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269319AbUJQUjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbUJQUgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:36:11 -0400
Received: from gprs214-97.eurotel.cz ([160.218.214.97]:13440 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269295AbUJQUdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:33:11 -0400
Date: Sun, 17 Oct 2004 22:26:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Byrne <john.l.byrne@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Still a mm bug in the fork error path
Message-ID: <20041017202652.GF7476@elf.ucw.cz>
References: <416C6915.9080201@hp.com> <Pine.LNX.4.58.0410121902100.3897@ppc970.osdl.org> <416CA0B1.20900@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416CA0B1.20900@hp.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In my kernel, it was a SIGKILL to a forking kernel thread that caused 
> the problem. While I see SIGKILLs being sent to some kernel threads, I 
> don't know if any of the kernel threads ever fork. If they don't, 
> barring a demented root user sending SIGKILLs to kernel threads, I don't 
> know if anyone else will ever see this. So, I don't have any problems 
> with it being fixed post 2.6.9.

Actually I do not think that root sending SIGKILLs to kernel threads
is demented... I tried to recover broken machine by SIGKILLing
kacpid. It did not work, so I just reniced it to get machine back.

								Pavel
PS: BTW it was evo n620c. There's something wrong with thermal
handling after swsusp. Evo will not die by overheat, but it almost
damaged machine it was standing on... ouch. Cover got deformed by
heat (quite a bit), fortunately it returned to previous shape when it
cooled down. 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
