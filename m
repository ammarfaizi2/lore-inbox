Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbUKKLTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbUKKLTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbUKKLNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:13:41 -0500
Received: from [195.135.223.242] ([195.135.223.242]:4480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262211AbUKKLLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:39 -0500
Date: Wed, 10 Nov 2004 18:11:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041110171115.GA1071@elf.ucw.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <20041101140717.GA1180@ucw.cz> <20041101172809.GB23341@elf.ucw.cz> <200411012318.45690.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411012318.45690.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > With accurate list "hotkeys" could run with no configuration, but I am
> > > > afraid maintaining accurate list of keys for each keyboard is way too
> > > > much work.
> > > 
> > > The lists need to be kept _somewhere_, so why not have a userspace
> > > database with a program that loads the description into the kernel at
> > > boot, possibly using DMI as a hint to what keyboard is connected?
> > 
> > Doing dmi blacklist from userspace is going to be pretty
> > painfull... Kernel already has all the infrastructure.
> > 
> > My preference is forget about providing list of keys (it never worked
> > anyway), and just fixup few notebooks we know...
> 
> What about all those "multimedia" and "Internet" keyboards out there?
> 
> Plus I don't think using DMI is a good idea. Many people use 2 keyboards
> with their laptops - built-in and external and DMI mapping will sure be
> wrong for external keyboard. Theoretically it should be possible to have
> several completely independent keyboards (at least as far as
> keycodes go).

Well, I only filled unused spots in mapping table. So it should not
cause any problem unless you attach non-standard keyboard to your evo,
and even in such case I cause no regression... 
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
