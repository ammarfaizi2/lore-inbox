Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTK3Re4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTK3Rez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:34:55 -0500
Received: from gprs151-64.eurotel.cz ([160.218.151.64]:6017 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264971AbTK3Rer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:34:47 -0500
Date: Sun, 30 Nov 2003 18:35:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: FYI: My current suspend bigdiff
Message-ID: <20031130173535.GC516@elf.ucw.cz>
References: <3FC789F5.2000208@gmx.de> <20031128175503.GB18072@elf.ucw.cz> <3FC7908A.9030007@gmx.de> <20031128235623.GB18147@elf.ucw.cz> <3FC8C0DB.9050107@gmx.de> <20031129172537.GB459@elf.ucw.cz> <3FC9C560.2070902@gmx.de> <20031130171833.GB516@elf.ucw.cz> <3FCA2742.8070107@gmx.de> <3FCA280A.40805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA280A.40805@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>>Well... it could work with scsi. You can try it, but be carefull. [If
> >>>>it goes wrong it might eat your data.]
> >>>
> >>>
> >>>Thats why I use xfs on my main system to test... And I tried with 
> >>>libata and it won't work as it complains that the "katad" process 
> >>>cannot be stopped, so swsusp immediatly comes back.
> >>
> >>
> >>
> >>I do not know how much more support is needed to allow powermanagment
> >>for libata, but this one should be easy...
> >
> >
> >Uhm, Jeff already fixed it in libata using the same call. Can both fixes 
> >"hurt" each other or are the safe?
> 
> 
> As you suspect, you want only one of the fixes.
> 
> I would probably prefer Pavel's patch over mine, as he knows the suspend 
> subsystem better than me :)

Well, as I did not even try to compile it, take Jeff's patch.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
