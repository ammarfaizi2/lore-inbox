Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJWXfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJWXfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:35:13 -0400
Received: from gprs147-238.eurotel.cz ([160.218.147.238]:11136 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261877AbTJWXfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:35:08 -0400
Date: Fri, 24 Oct 2003 01:34:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kill unneccessary debug printk
Message-ID: <20031023233453.GA847@elf.ucw.cz>
References: <E1ACnDZ-0005GV-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ACnDZ-0005GV-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    > Actually, that 'printk' is useful.  As i understand it, the only way software
>    > suspend is going to work is that if the same video mode is used on resume as
>    > on booting.  If one uses "vga=ask", then one can 'dmesg | grep' to generate
>    > a proper string for 'lilo -R' (which i already do to make sure the correct
>    > kernel gets resumed during testing).  If i'm mistaken about needing to set
>    > VGA mode identically on resume, then i have no objection to removing the
>    > printk.
> 
>    Oops, someone is using my debug printk :-(. I'll at least try
>    to merge it with some other msg, so it does not waste full
>    line.
> 
> Better yet, let's take this opportunity to do this more cleanly.  How 
> about having something like /sys/power/vmode (or /proc/...) contain that 
> inforemation instead?  With luck, it might even be few kernel bytes than
> the original printk (or at least not much more).  (I know nothing about
> either /proc or /sys, so it would take me awhile to suggest a patch).

Well, you probably know about as much as I do. I'm afraid I'm just
going to take the easy way out.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
