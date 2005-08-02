Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVHBLEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVHBLEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVHBLEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:04:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45522 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261491AbVHBLE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:04:29 -0400
Date: Tue, 2 Aug 2005 13:04:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Eugene Pavlovsky <heilong@bluebottle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFE: console_blank_hook that calls userspace helper
Message-ID: <20050802110418.GB1390@elf.ucw.cz>
References: <1122891737.42edf7d9a402a@www.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122891737.42edf7d9a402a@www.bluebottle.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> http://bugzilla.kernel.org/show_bug.cgi?id=4767:
> 
> Bugzilla Bug 4767 	RFE: console_blank_hook that can call userspace
> program
> Submitter:   	heilong@bluebottle.com (Eugene Pavlovsky)
> 
> I think it'd be very good to have a console_blank_hook handler that
> would call a
> userspace program/script/generate hotplug event whatever. Currently,
> the console
> can only be blanked using APM, so no options exist for people using
> ACPI. I've
> got a Radeon graphics chip on my laptop, and the LCD backlight can be
> controlled
> (on/off) using radeontool. If there was a userspace callback
> interface
> to
> console blanking, I would just make a callback script that calls
> "radeontool
> light off" on blank and "radeontool light on" on unblank - really
> easy. I think
> this userspace console_blank_hook handler is very simple to put into
> kernel, but
> I'm not a kernel developer myself, so wouldn't risk sending any
> patches (that
> call system("some_script")), because I probably won't make things as
> they should
> be in the kernel.

Radeonfb should blank console automatically, without userspace
helper. Send a patch to do that ;-).

								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
