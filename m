Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWDXH6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWDXH6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDXH6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:58:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62623 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751094AbWDXH6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:58:00 -0400
Date: Mon, 24 Apr 2006 09:57:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: dean gaudet <dean@arctic.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] off-by-1 in kernel/power/main.c
Message-ID: <20060424075725.GB26345@elf.ucw.cz>
References: <Pine.LNX.4.64.0604212055390.24100@twinlark.arctic.org> <20060422213754.GA23981@elf.ucw.cz> <Pine.LNX.4.64.0604231958020.22072@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604231958020.22072@twinlark.arctic.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Valid way to power off machine is by shutdown -o now, and there's a
> > syscall to do that. It should not be done by /sys/power/state.
> 
> hey... my shutdown doesn't have a -o option... where can i find that?

Not sure where I got it, because _my_ shutdown does not have -o,
either. Sorry. It has 

       -P     Halt action is to turn off the power.

however. Plus there's a syscall you can use...
								Pavel
-- 
Thanks for all the (sleeping) penguins.
