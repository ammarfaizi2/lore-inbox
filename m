Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269440AbUIYXlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbUIYXlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269441AbUIYXlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:41:05 -0400
Received: from gprs214-184.eurotel.cz ([160.218.214.184]:47232 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269440AbUIYXlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:41:03 -0400
Date: Sun, 26 Sep 2004 01:40:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040925234045.GA17856@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409251214.28743.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've just tried to suspend my box and I must admit I've given up after 30 
> minutes (sic!) of waiting when there were only 12% of pages written to disk.  
> Apparently, swsusp slows down to an unacceptable level after saying "PM: 
> Writing image to disk".
> 
> The box is an Athlon 64-based notebook.  The .config is available at:
> http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3.config
> and the output of dmesg is available at:
> http://www.sisk.pl/kernel/040925/2.6.9-rc2-mm3-dmesg.log

We have seen something similar after hdparm was used on specific
machines. Are you using hdparm?
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
