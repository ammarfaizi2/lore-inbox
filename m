Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSG2OOB>; Mon, 29 Jul 2002 10:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSG2OOB>; Mon, 29 Jul 2002 10:14:01 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1664 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317257AbSG2OOA>;
	Mon, 29 Jul 2002 10:14:00 -0400
Date: Mon, 29 Jul 2002 10:30:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, davej@suse.de,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [PATCH] Read-Copy Update 2.5.28 [resent]
Message-ID: <20020729083007.GA115@elf.ucw.cz>
References: <20020725222146.A12780@in.ibm.com> <20020726132107.D16440@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726132107.D16440@in.ibm.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Currently, it seems useful for -
> 
> 1. CPU hotplug (synchronize_kernel())
> 2. ipv4 route cache lookup
> 3. dentry cache lookup [ more results and new patch on the way ]
> 4. Potential uses in XFS (Christoph ?)

Can it be used to make module unloading less painfull?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
