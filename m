Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVHAH2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVHAH2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVHAH1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:27:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24037 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262419AbVHAH0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:26:48 -0400
Date: Mon, 1 Aug 2005 09:26:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801072600.GM27580@elf.ucw.cz>
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <20050731220754.GE7362@voodoo> <20050731223616.GB27580@elf.ucw.cz> <20050801034940.GC24130@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801034940.GC24130@mail>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If the kernel defaults are irrelevant, then it would make more sense to
> > > leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
> > > order to keep with the principle of least surprise for people who do use
> > > kernel.org kernels.
> > 
> > Well, I'd say you want ACPI enabled. New machine do not even boot
> > without that. Default config should be usefull; set ACPI off, and
> > you'll not be able to even power machine down.
> 
> And there are older machines that won't boot with it enabled. The machine
> I'm typing this on has a really shitty ACPI implementation, I don't remember
> the details because it's been so long but I know that I have to disable ACPI 
> for it to work right.

If it was long ago, you probably want to try again and file a bug
report if still broken.

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
