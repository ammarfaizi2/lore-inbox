Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVFFV6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVFFV6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFFV6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:58:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261639AbVFFV6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:58:39 -0400
Date: Mon, 6 Jun 2005 23:58:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@zip.com.au>,
       ACPI devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Message-ID: <20050606215815.GO2230@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <200506061902.34304.rjw@sisk.pl> <20050606171417.GB2230@elf.ucw.cz> <200506062346.09503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506062346.09503.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, I see it on i386, too. Try patch below; if it frees some after
> > first pass, you have that problem, too.
> 
> I've run it once and the result is this:
> 
> Freeing memory... done (75876 pages freed)
> Freeing memory... done (1536 pages freed)
> Freeing memory... done (0 pages freed)
> Freeing memory... done (1792 pages freed)
> Freeing memory... done (0 pages freed)
> 
> It does free some pages after the first pass, but this is only a small fraction
> of all pages freed.  I wouldn't call it a bad result ...

Well, it still did not free all memory it should have freed, and you
were lucky. Apparently for some people it does not that well (and that
includes me, I see 0 in first pass quite often).
								Pavel
