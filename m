Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVACSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVACSJW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVACSFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:05:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31762 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261649AbVACSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:04:35 -0500
Date: Mon, 3 Jan 2005 19:04:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103180430.GM2980@stusta.de>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:18:36PM -0500, Bill Davidsen wrote:
>...
> The "few minor exceptions:"
> 
> SCSI command filtering - while I totally support the idea (and always
> have), I miss running cdrecord as a normal user. Multisession doesn't work
> as a normal user (at least if you follow the man page) because only root
> can use -msinfo. There's also some raw mode which got a permission denied,
> don't remember as I was trying something not doing production stuff.
> 
> APM vs. ACPI - shutdown doesn't reliably power down about half of the
> machines I use, and all five laptops have working suspend and non-working
> resume. APM seems to be pretty unsupported beyond "use ACPI for that."
>...

More serious were other problems like e.g. the problems XFS has (had?) 
with the 4kB stacks option on i386 that was introduced in 2.6
after 2.6.0 . 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

