Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSGHWoe>; Mon, 8 Jul 2002 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSGHWod>; Mon, 8 Jul 2002 18:44:33 -0400
Received: from mail.uklinux.net ([80.84.72.21]:521 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S317209AbSGHWob>;
	Mon, 8 Jul 2002 18:44:31 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 8 Jul 2002 23:45:59 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Chris Rankin <cj.rankin@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Scary VM message with Linux 2.4.19-pre9-ac3
In-Reply-To: <200207081937.g68Jbi8t000811@twopit.underworld>
Message-ID: <Pine.LNX.4.21.0207082331130.32419-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002, Chris Rankin wrote:

> Hi,
> 
> I have just seen this message appear in my kernel log:
> 
> Jul  8 20:20:44 twopit kernel: do_wp_page: bogus page at address 40fb8000 (page 0xc2f96990)
> Jul  8 20:20:44 twopit kernel: VM: killing process setiathome
> 
> I am running Linux-2.4.19-pre9-ac3 on a dual 733 MHz PIII, with 1.25
> GB RAM, devfs, ALSA-CVS and lm_sensors 2.6.3, and this is the first
> time I have *ever* seen this message. To be fair, I've been suspecting
> memory corruption in 2.4.18+ kernels for a long time, and this message
> did not produce an oops, but I am *particularly* spooked this time
> because this it happened (only once) just *minutes* after my first
> reboot since an important BIOS upgrade. Normally, the machine stays up
> for about a week before it needs a maintenance reboot.
>

 Chris, I don't think I understand your definition of `maintenance' - one
of my boxes sometimes gets rebooted more often than weekly, but only if
I'm testing new pre-patches or new -ac patches, or if I'm testing a full 
system rebuild. Your kit doesn't sound *bleeding_edge*, I'd expect it to
keep running for weeks or months.

 Having said that, I've never upgraded a bios in my life, and I'd get
worried to get these messages afterwards. Why did you already suspect
memory corruption ? 

> Everything still fine so far ... see that rubik's cube go...
> 
> I have previously run memtest-3.0 over all my RAM and it has checked
> out.
>

 Never tried this version, but I was having a lot of problems 18 months
ago, and again more recently when a fan started to fail. At those times
memtest86 detected no problems. If you want to provoke sig 11, the best 
options are running jade (make htmldocs or whatever you prefer), building 
the kernel, and (best/worst test) building gcc. 

> Should I worry?
> 

 Have you considered the usual problems (poor cooling, inadequate power
supply) ? - I know you're using Intel cpus, but even they need cooling and
power. Do you get reliable readings from lm_sensors ?

> Cheers,
> Chris
> -

Ken
-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.



