Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbULYW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbULYW0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULYW0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:26:49 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:63106 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261582AbULYW0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:26:40 -0500
Date: Sat, 25 Dec 2004 23:26:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dan Sturtevant <sturtx@gmail.com>
Cc: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: fork/clone external to a process?
Message-ID: <20041225222625.GB27315@elf.ucw.cz>
References: <7d92433304122107491b8b624a@mail.gmail.com> <41C8B128.7010201@xs4all.nl> <7d92433304122116361c2933fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d92433304122116361c2933fb@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My problem is that I want this to happen on demand rather than
> whenever the substituted shared library call is invoked inside the
> executable.
> 
> I haven't messed around with LD_PRELOAD before.  Am I interpreting
> everything correctly here or am I way off base?

gdb attach the vmware, then force it to call routine you preloaded...

Or look at subterfugue.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
