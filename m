Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUIZWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUIZWmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUIZWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:42:14 -0400
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:48513 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264530AbUIZWmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:42:13 -0400
Date: Mon, 27 Sep 2004 00:41:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926224156.GR28810@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261906.10635.rjw@sisk.pl> <20040926183449.GA28810@elf.ucw.cz> <200409262125.38271.rjw@sisk.pl> <41572B34.3010209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41572B34.3010209@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I guess it will, but I'll check.
> 
> please try attached patch first. The comments should explain it pretty
> well. It seems to have helped me: without it, sysrq-p during writing
> (even if not that slow) almost always was in pccardd, now it is idling
> in swapper task.
> Maybe i am totally wrong but you may give it a shot.

I do not think it is right, interrupts may be needed for writing
image.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
