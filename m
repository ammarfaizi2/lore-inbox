Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291191AbSBLVPW>; Tue, 12 Feb 2002 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291192AbSBLVPM>; Tue, 12 Feb 2002 16:15:12 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:55564 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S291191AbSBLVPF>;
	Tue, 12 Feb 2002 16:15:05 -0500
Date: Tue, 12 Feb 2002 17:59:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@transmeta.com, reality@delusion.de,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.4-pre6 apm compile fix
Message-ID: <20020212165959.GA148@elf.ucw.cz>
In-Reply-To: <3C672BE8.EF4C703F@delusion.de> <E16a6jj-0005Gu-00@the-village.bc.nu> <20020212122143.4b6cbd0b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212122143.4b6cbd0b.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch just resyncs the driver with 2.4.18-pre (which is what is
> being testd by others).  The only outstanding known problem is some
> very strange interaction with VMWARE.  But otherwise people seem
> happy with the changes.
> 
> Original announcement to Dave Jones and Marcelo:
> 
> 	Update a couple of email addresses
> 	Fix the idle handling (this is an improved version of the fix
> 		that Alan Cox has in his -ac tree)
> 	Notify user mode of suspend events before drivers (fix)
> 	Make the idling percentage boot time configurable

Maybe its time to kill CONFIG_APM_CPU_IDLE? No need for CONFIG_ option
when its configurable at boot time, right?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
