Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272610AbTHEJTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTHEJTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:19:40 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:3997 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272610AbTHEJSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:18:08 -0400
Date: Tue, 5 Aug 2003 11:17:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] save/restore screen support for ACPI S3 sleep
Message-ID: <20030805091734.GE388@elf.ucw.cz>
References: <20030726225646.GA519@elf.ucw.cz> <Pine.LNX.4.44.0308041800461.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041800461.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This way console should be correctly restored after S3...
> > 
> > [Prototype should be added to include/linux/suspend.h].
> > 
> > kernel/suspend.c part only moves code out of "SWSUSP_ONLY"
> > section.
> 
> I moved this code to kernel/power/console.c and made it dependent on 
> CONFIG_PM only. I also fixed up the breakage Andrew reported earlier and 
> added prototypes to include/linux/suspend.h. Patch below for review (not 
> directly applicable, as it's relative to the series).

Patch looks good, except that you should put some comment at begining
of console.c. (GPL+copyrights+one line what this file is about). I
guess that's trivial to fix up incrementally.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
