Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFCXLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFCXLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVFCXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:11:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:998 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261169AbVFCXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:11:03 -0400
Date: Sat, 4 Jun 2005 00:47:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050603224750.GA1804@elf.ucw.cz>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603223758.GA2227@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Should be fixed now, the header was defining it as a function un UP
> > system with no local apic. Can you try the following version?
> 
> Some comments below...

Seems to work okay here. Even with CONFIG_DYN_TICK_USE_APIC=y.

								Pavel
