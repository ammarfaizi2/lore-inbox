Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261770AbTCGU06>; Fri, 7 Mar 2003 15:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbTCGU06>; Fri, 7 Mar 2003 15:26:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261770AbTCGU05>;
	Fri, 7 Mar 2003 15:26:57 -0500
Date: Fri, 7 Mar 2003 21:36:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030307203650.GB2447@elf.ucw.cz>
References: <20030305180222.GA2781@zaurus.ucw.cz> <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The cumulative patch is here:
> 
> http://kernel.org/pub/linux/kernel/people/mochel/power/pm-2.5.64.diff.gz

Hmm, I am not sure if drivers/power is the right place for stuff like
fridge.c. That might be usefull for other stuff, too.

I do not think placing swsusp.h in drivers/power/swsusp is right. It
should be in include/linux or include/linux/power.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
