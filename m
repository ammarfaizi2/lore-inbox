Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVCTTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVCTTZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVCTTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:25:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39071 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261183AbVCTTYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:24:35 -0500
Date: Sun, 20 Mar 2005 20:24:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp smp problems... [was Re: swsusp: Remove arch-specific references from generic code]
Message-ID: <20050320192422.GB1401@elf.ucw.cz>
References: <20050316001207.GI21292@elf.ucw.cz> <20050319132815.4f51a7e5.akpm@osdl.org> <20050319220735.GC1835@elf.ucw.cz> <200503200129.35739.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503200129.35739.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

At least part of them is caused by CONFIG_MTRR. I had to disable it on
i386 to make it work...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
