Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVLGLFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVLGLFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVLGLFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:05:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51336 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750841AbVLGLFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:05:33 -0500
Date: Wed, 7 Dec 2005 12:05:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051207110521.GB2563@elf.ucw.cz>
References: <43923479.3020305@tls.msk.ru> <20051204003130.GB1879@kroah.com> <386F0C1C.1040509@tls.msk.ru> <20051205132048.GB7478@elf.ucw.cz> <4396BBF4.4010609@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396BBF4.4010609@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 07-12-05 13:39:48, Michael Tokarev wrote:
> Pavel Machek wrote:
> >>I tried various 'wakeup' settings in bios, incl. turning everything
> >>off in that menu - no difference.
> >>
> >>The same behaviour is shown by all 2.6 kernels I tried so far
> >>(since 2.6.6 or so).
> > 
> > Try ACPI wakeup settings, and ask on ACPI lists. Unfortunately noone
> > really cares about standby these days.
> 
> Which "ACPI wakeup settings" did you mean?  In BIOS or in kernel?

/proc/acpi/wakeup. And do ask on acpi mailing lists.

> Too bad no one cares about standby.. :(
> I've several of those systems, and I love them for their quiet
> operation.  The only problem for me is the system startup time
> (about 3 minutes) and applications startup time (due to the
> empty filesystem cache) -- it'd be very nice to be able to
> suspend the system somehow instead of turning it off...  Now,
> suspend to disk does not work at all (that 4M pages stuff on
> a VIA C3 CPU), suspend to mem does not work either, and "normal"
> standby, while works, triggers a wakeup almost immediately.
> So, in short, no suspend at all...

Well, printk time. Find out what is wrong. Noone else can because lack
of hardware.
								Pavel
-- 
Thanks, Sharp!
