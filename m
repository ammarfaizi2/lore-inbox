Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUGDPTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUGDPTH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUGDPTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:19:06 -0400
Received: from gprs214-240.eurotel.cz ([160.218.214.240]:46728 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265732AbUGDPTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:19:04 -0400
Date: Sun, 4 Jul 2004 17:18:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040704151848.GC8488@elf.ucw.cz>
References: <20040703172843.GA7274@linux.nu> <20040703204647.GE31892@elf.ucw.cz> <20040704133715.GA4717@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704133715.GA4717@linux.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are moving it inside function that should have no business doing
> > this... Would something like this work better? [hand-edited, apply by
> > hand; untested].
> 
> Your patch works fine but now the swsusp resume messages appears on the
> normal console instead. The swsusp console should be allocated earlier as my
> patch did.

Actually, this has several advantages -- you can actually see the
messages of the kernel during resume. And reading does logically
belong to the kernel doing boot, so it belongs on its screen, too...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
