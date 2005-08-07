Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752550AbVHGSvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbVHGSvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbVHGSvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:51:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47515 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752550AbVHGSvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:51:21 -0400
Subject: Re: Lost Ticks on x86_64
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Erick Turnquist <jhujhiti@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73mznuc732.fsf@bragg.suse.de>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
	 <p73mznuc732.fsf@bragg.suse.de>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 14:51:19 -0400
Message-Id: <1123440679.12766.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 13:36 +0200, Andi Kleen wrote:
> Erick Turnquist <jhujhiti@gmail.com> writes:
> 
> > Hi, I'm running an Athlon64 X2 4400+ (a dual core model) with an
> > nVidia GeForce 6800 Ultra on a Gigabyte GA-K8NXP-SLI motherboard and
> > getting nasty messages like these in my dmesg:
> > 
> > warning: many lost ticks.
> > Your time source seems to be instable or some driver is hogging interupts
> > rip default_idle+0x20/0x30
> 
> It's most likely bad SMM code in the BIOS that blocks the CPU too long
> and is triggered in idle. You can verify that by using idle=poll
> (not recommended for production, just for testing) and see if it goes away.
> 

WTF, since when do *desktops* use SMM?  Are you telling me that we have
to worry about these stupid ACPI/SMM hardware bugs on the desktop too?

Lee

