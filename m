Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVGaWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVGaWlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVGaWit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:38:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29084 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262018AbVGaWgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:36:25 -0400
Date: Mon, 1 Aug 2005 00:36:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731223616.GB27580@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <20050731220754.GE7362@voodoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731220754.GE7362@voodoo>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I really like having 250HZ as an _option_, but what I don't see is why 
> > > it should be the _default_.  I believe this is Lee's position as
> > > Last I checked, ACPI and CPU speed scaling were not enabled by default; 
> > 
> > Kernel defaults are irelevant; distros change them anyway. [But we
> > probably want to enable ACPI and cpufreq by default, because that
> > matches what 99% of users will use.]
> > 
> 
> If the kernel defaults are irrelevant, then it would make more sense to
> leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
> order to keep with the principle of least surprise for people who do use
> kernel.org kernels.

Well, I'd say you want ACPI enabled. New machine do not even boot
without that. Default config should be usefull; set ACPI off, and
you'll not be able to even power machine down.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
