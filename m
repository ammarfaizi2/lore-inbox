Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVHDV6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVHDV6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVHDVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:42:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262737AbVHDVmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:42:17 -0400
Date: Thu, 4 Aug 2005 23:40:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
Message-ID: <20050804214044.GD1780@elf.ucw.cz>
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050804142548.5b813700.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804142548.5b813700.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Does resuming from swsuspend work for anyone with amd64-agp loaded?
> 
> It would seem not ;)
> 
> > On my system when I suspend with amd64-agp loaded, I get a spontaneous 
> > reboot on resume. It reboots immediately after reading the saved image 
> > from disk.
> > This is 100% reproducible.
> > 
> > Athlon 64 FX-53, Asus A8V Deluxe, Linux 2.6.13-rc3-mm1.
> 
> If this is reproducible in the soon-to-be-released 2.6.13-rc6 then could
> you please raise an entry at bugzilla.kernel.org and we'll plug away at it
> as the suspend stuff continues to get sorted out, thanks.

I assume it is in -rc6, too; it is long-standing bug and I am not
aware of any attempts at fixing it. Please file bug report, assign to
me.

OTOH it is not regression; AFAIK it never worked. Please do not let it
block 2.6.13.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
