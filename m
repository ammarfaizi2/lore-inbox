Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRIPKKr>; Sun, 16 Sep 2001 06:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRIPKKg>; Sun, 16 Sep 2001 06:10:36 -0400
Received: from cx730939-a.elcjn1.sdca.home.com ([24.5.14.11]:63411 "EHLO
	highwind.timespace.dhs.org") by vger.kernel.org with ESMTP
	id <S270134AbRIPKKR>; Sun, 16 Sep 2001 06:10:17 -0400
Date: Sun, 16 Sep 2001 03:10:40 -0700
From: Brian Bennett <bahamat@timespace.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x won't boot on sony vaio pcg-fx215
Message-ID: <20010916031040.A17590@timespace.dhs.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've been trying to get some version of 2.4.x to boot on my laptop for
some time now with no luck. I figure it's either my UBD, a bug, or my hardware
just sucks, I'd like to figure out which.

Anyway, my specs:
Sony VAIO PCG-FX215
CPU AMD Duron 800
MB is Via82c686
128M ram
distro is Debian sid, but I've tried others that come with 2.4 kernel such as
Mandrake.
I think that's all the relevant stuff(?) but I can get the details on any
other hardware that might be relavent.

My errors:
I don't have any specifics because with different configs I get different
errors and I don't know how to get dumps of the errors, but the usual ones are
along the lines of:
unable to handle kernel paging request
kernel panick: tried to kill init
kernel panick: tried to kill the idle task

What I've tried:
setting cpu choice to amd/duron, pentium, 386, 686
enable/disable apm, acpi, pcmcia, usb, ieee1394 (and anything else that looked
good at the time, but I don't remember all of them).
passing mem=128M to the kernel (grasping at straws here)

Something else that may be helpful, I had to disable PCMCIA support to get the
Install CD to boot, and I've never gotten it or USB to work (I'm not very
concerned about those though, I don't have any PCMCIA cards or USB devices I
want to use).

2.2.x kernels boot fine (without pcmcia or usb) and I've been using 2.2.19 for
the past few months, but I have a DVD drive and I want to watch movies.

I read something rom ac a while back about AMD and VIA saying that it's just
broken, it's VIA's fault and to not expect a fix any time soon. How can I
verify that is/isn't me?

Anyway, I guess the first step is how can I go about gathering more info so
we can find out exactly what it is that's causing the problem?

TIA for any help.

-- 
Brian Bennett
bahamat@timespace.dhs.org * http://timespace.dhs.org/

On 16 July 2001, Russian programmer Dmitry Sklyarov was arrested by
federal agents in Las Vegas, Nevada. His crime: pointing out major
security flaws in Adobe PDF and eBook software.

To see how you can help Dmitry visit http://www.freesklyarov.org/
