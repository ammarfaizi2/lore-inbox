Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUKARbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUKARbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S280980AbUKARbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:31:17 -0500
Received: from gprs214-124.eurotel.cz ([160.218.214.124]:52609 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S271911AbUKAR2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:28:23 -0500
Date: Mon, 1 Nov 2004 18:28:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Message-ID: <20041101172809.GB23341@elf.ucw.cz>
References: <20041031213859.GA6742@elf.ucw.cz> <200410312016.08468.dtor_core@ameritech.net> <20041101080306.GA1002@elf.ucw.cz> <20041101093830.GA1145@ucw.cz> <20041101133214.GE32347@atrey.karlin.mff.cuni.cz> <20041101140717.GA1180@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101140717.GA1180@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > With accurate list "hotkeys" could run with no configuration, but I am
> > afraid maintaining accurate list of keys for each keyboard is way too
> > much work.
> 
> The lists need to be kept _somewhere_, so why not have a userspace
> database with a program that loads the description into the kernel at
> boot, possibly using DMI as a hint to what keyboard is connected?

Doing dmi blacklist from userspace is going to be pretty
painfull... Kernel already has all the infrastructure.

My preference is forget about providing list of keys (it never worked
anyway), and just fixup few notebooks we know...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
