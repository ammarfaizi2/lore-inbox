Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVCEVTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVCEVTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVCEVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:19:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17370 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261168AbVCEVSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:18:41 -0500
Date: Sat, 5 Mar 2005 22:17:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       Len Brown <len.brown@intel.com>
Subject: Re: s4bios: does anyone use it?
Message-ID: <20050305211747.GF1424@elf.ucw.cz>
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422A1FB6.3000504@ens-lyon.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Is there single user of s4bios? It used to work for me 4 notebooks
> >ago, but I never really used it. I think I'm the only person that ever
> >seen it working, but I could be wrong. Is there anyone using s4bios in
> >2.6.11?
> >
> >If not, I guess we should remove that code from kernel. It is not
> >usefull, and it is likely broken.
> >								Pavel

> I always suspend my Compaq Evo N6OOc to disk using "echo 4b > 
> /proc/acpi/sleep".
> I don't remember the reason why I originally did choose this one instead of 
> S4.
> I just checked that S4 and S4Bios work the same on 2.6.11-mm1 (even with my
> PCMCIA wireless card connected, great!).
> From what I remember, I didn't see any difference between S4 and S4Bios in
> recent vanilla kernels.

Can you try cat /proc/acpi/sleep? If there's no difference between S4
and S4bios, than you are probably just using plain S4...

> By the way, it seems that Radeon makes suspend slower because it needs
> to be blanked or something like that. Is there any way to avoid this ?

Yes, but it will take quite long to do it properly. pm_message_t
framework needs to go in, first.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
