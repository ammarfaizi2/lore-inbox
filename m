Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTBUVTX>; Fri, 21 Feb 2003 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbTBUVTX>; Fri, 21 Feb 2003 16:19:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:28032 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267716AbTBUVTU>;
	Fri, 21 Feb 2003 16:19:20 -0500
Date: Tue, 18 Feb 2003 09:02:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrej Ricnik <a.ricnik@niwa.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-Kernels 2.4.xx, apm & P4 issues
Message-ID: <20030218080215.GA137@elf.ucw.cz>
References: <200302171527.19066.a.ricnik@niwa.cri.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302171527.19066.a.ricnik@niwa.cri.nz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> and my apologies for the general direction.
> 
> I have googled on this topic, asked on discussion boards
> and couldn't find any suitable hints.
> 
> The problem that I encounter is happening on a mobile P4.
> When apm is active (I've compiled it as a module in
> both a 2.4.18 and 2.4.20 kernel) my system clock errs
> by as much as 90 seconds in an hour. Also, I seem to
> experience keyboard related problems (Ctrl, Alt, Shift get
> *sticky* -excuse my wording, I can't think of a better 
> description- that is, if I press them while typing normally,
> even though they are released physically their functionality
> carries on. Also the cursor keys sometimes issue numbers rather
> than cursor-movement) when apm is running.

> The machine in question is a IBM Thinkpad R32, mobile P4 1.8GHz,
> 512MB RAM.

Seems that crappy apm bios takes long to execute, and interrupts are
probably off during that. Try enabling interrupts during apm; try
acpi.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
