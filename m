Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTDWOYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTDWOYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:24:51 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:40630 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264042AbTDWOYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:24:49 -0400
Date: Wed, 23 Apr 2003 16:35:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 582] New: network device does not survive laptop suspend
Message-ID: <20030423143521.GA1285@elf.ucw.cz>
References: <11750000.1050332723@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11750000.1050332723@[10.10.2.4]>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> http://bugme.osdl.org/show_bug.cgi?id=582
> 
>            Summary: network device does not survive laptop suspend
>     Kernel Version: 2.5.66
>             Status: NEW
>           Severity: high
>              Owner: apmbugs@rothwell.emu.id.au
>          Submitter: devilkin@gmx.net
> 
> 
> Distribution: Debian Unstable
> Hardware Environment: Dell Latitude CPxJ 650
> Software Environment: ?
> Problem Description: 
> 
> I suspended my laptop this morning to move it from home to work without having
> to shhutdown everything. The laptop came nicely out of the suspend, except
> for my Cardbus ethernet device.
> 
> Since i resumed the laptop it hangs around every 10 seconds for around 2
> seconds. Everything hangs, from mouse movement, to audio playback, to
> pinging. This is seen in syslog, in great numbers:

> eth0: Transmitter encountered 16 collisions -- network cable problem?
> eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
>   Flags; bus-master 1, dirty 0(0) current 16(0)
>   Transmit list ffffffff vs. ce6da200.
> eth0: command 0x3002 did not complete! Status=0xffff

ACPI or APM sleep? suspend-to-RAM or disk? I see apmbugs as a owner...

Anyway it is up to someone with affected ethernet card to fix it...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
