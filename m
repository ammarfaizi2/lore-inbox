Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUJKSYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUJKSYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUJKSYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:24:51 -0400
Received: from gprs212-86.eurotel.cz ([160.218.212.86]:21632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269172AbUJKSXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:23:22 -0400
Date: Mon, 11 Oct 2004 20:23:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brice.Goglin@ens-lyon.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
Message-ID: <20041011182309.GD1007@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz> <416AAC5F.7020109@ens-lyon.fr> <20041011161718.GA1045@elf.ucw.cz> <416ABE31.3040004@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416ABE31.3040004@ens-lyon.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>On my N600c, suspend-to-RAM seems to complete... but when I try to wake 
> >>up the laptop (by pressing the power button), it blinks strangely and 
> >>then immediately shutdowns instead of resuming...
> >
> >
> >Your machine is probabl different from N620c i this regard...
> >
> >Can you test if it reaches start of wakeup.S? Just insert infinite
> >loop there...
> 
> Well, my apologies, the behavior changed recently:
> * S1 seems to work.
> * S3 is so buggy: suspend still seem to complete. Pushing the power 
> button to resume doesn't shutdown the machine anymore: the laptop wakes 
> up but doesn't write or do anything. I'm only able to stop it by 
> pressing the power button.

Hmm, and is the linux alive (like capslock works?) or do you need
hard poweroff?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
