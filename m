Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263221AbVBEJkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVBEJkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbVBEJkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:40:37 -0500
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:61671 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266280AbVBEJhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:37:54 -0500
Date: Sat, 5 Feb 2005 10:37:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Message-ID: <20050205093740.GD1158@elf.ucw.cz>
References: <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz> <9e4733910502040931955f5a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502040931955f5a6@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not understand how initramfs fits into picture... Plus lot of
> > people (me :-) do not use initramfs...
> 
> The final fix for this will include the video reset app on initramfs.
> I already have code in the kernel for telling the primary video card
> from secondary ones. When the kernel is initially booting and finds

Is initramfs preserved when system is running? I was under impression
that it is freed when we mount real / fs.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
