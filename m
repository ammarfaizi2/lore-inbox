Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSJHULb>; Tue, 8 Oct 2002 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSJHTMU>; Tue, 8 Oct 2002 15:12:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15876 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263207AbSJHTG1>;
	Tue, 8 Oct 2002 15:06:27 -0400
Date: Tue, 8 Oct 2002 13:20:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: swsusp 2.4.18 vs 2.5.40
Message-ID: <20021008132033.B35@toy.ucw.cz>
References: <20021002034825.GA1892@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021002034825.GA1892@top.worldcontrol.com>; from brian@worldcontrol.com on Tue, Oct 01, 2002 at 08:48:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> >Yep, swsusp is not really meant to work in 2.4.X. Get latest 2.5.X...  
> >and add IDE patches so it does not eat your disk...                    
> 
> Ok, I've compiled and tried 2.5.40.
> 
> Zip. Nada. swsusp doesn't show up at all.  If I compile with SMP
> turned on I get a message about swsusp being incompatible with
> SMP.  Running UP it doesn't show up in the boot log, though it
> looks to be compiled.
> 
> It also doesn't show in the SysRq help list.
> 
> echo'ing things to /proc/acpi/sleep does nothing.

Bad test in acpi/sleep.c; then IDE fix is needed and andrew's mm patch
to really free memory.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

