Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUACS1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUACS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:27:50 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:59264 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263645AbUACS1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:27:49 -0500
Date: Sat, 3 Jan 2004 19:28:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20040103182813.GB1080@elf.ucw.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk> <20031230165042.B13556@flint.arm.linux.org.uk> <20031230181741.D13556@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031230181741.D13556@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > It seems that my BIOS is taking exception to CTR value we're writing.
> > 
> > My next step will be to try this with 2.6.0 and see whether this is the
> > only issue affecting APM suspend.  In the mean time, does Vojtech have
> > any hints?
> 
> Ok, further info with 2.6.0:
> 
> - disabling i8042.c completely by adding return 0; to the start of
>   i8042_init() allows the suspend hotkey to work, and it works
>   multiple times!  The hibernate hotkey also works, but once the
>   laptop has resumed from hibernate, it's no longer possible to
>   suspend it.

You might want to use swap suspend instead of hibernate... at least we
have full control over that one.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
