Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTKTXyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTKTXyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:54:49 -0500
Received: from gprs147-68.eurotel.cz ([160.218.147.68]:14977 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264077AbTKTXxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:53:48 -0500
Date: Fri, 21 Nov 2003 00:54:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Martin Schlemmer <azarah@nosferatu.za.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: driver model for inputs
Message-ID: <20031120235410.GB431@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com> <20031120222825.GE196@elf.ucw.cz> <55080000.1069368524@w-hlinder> <20031120225504.GG196@elf.ucw.cz> <56710000.1069370317@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56710000.1069370317@w-hlinder>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you could post -test8 version, that would be great.
> 
> It is actually test5. Ive been working on multiple sysfs patches, the parport one is test8. 
> Ill get started on this one again and send out a cleaned up test9 version in a bit. This 
> one is pretty ugly because it's got lots of printks in it. I was going to break it up before
> submitting it too. But here ya go...

[Snip snip; most of patch seems to be moving from something.dev to
something-> dev]

This seems to deal with udev aspect of the problem... Do you have any
ideas have powermanagment fits into the picture? I need a way to hook
suspend() and resume() methods, so that I can fix keyboard/mouse after
sleep.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
