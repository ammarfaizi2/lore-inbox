Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759664AbWLCNLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbWLCNLq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759666AbWLCNLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:11:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10249 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1759663AbWLCNLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:11:46 -0500
Date: Sun, 3 Dec 2006 13:11:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Message-ID: <20061203131124.GG4773@ucw.cz>
References: <200612031526.00861.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612031526.00861.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I started to notice it some time ago; I can't say exactly if this was not 
> present in earlier versions because recently I switched from STR (which gave 
> me no end of troubles) to STD. So I may have not seen it before.
> 
> Suspend to disk while on battery. Plug in AC, resume. ACPI continues to show 
> AC adapter as not present:
> 
> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> state:                   off-line
> 
> replugging AC correctly changes state to on-line.

try echo platform > /sys/power/disk.
						Pavel
-- 
Thanks for all the (sleeping) penguins.
