Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRITUKH>; Thu, 20 Sep 2001 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274628AbRITUJ5>; Thu, 20 Sep 2001 16:09:57 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S274627AbRITUJs>;
	Thu, 20 Sep 2001 16:09:48 -0400
Date: Thu, 20 Sep 2001 09:23:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Knut.Neumann@rz.uni-duesseldorf.de
Subject: Re: SonyPI Driver
Message-ID: <20010920092313.A38@toy.ucw.cz>
In-Reply-To: <20010918182011.G14639@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010918182011.G14639@come.alcove-fr>; from stelian.pop@fr.alcove.com on Tue, Sep 18, 2001 at 06:20:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I noticed that when running the sonypi driver on my VAIO z600tek, APM Suspend
> > does no longer work: The power button (to suspend) does no longer work and -
> > well - it will still suspend if I force it to, by apm -s but it does not
> > resume (powers on, but blank screen and no input gets processed).
> 
> Yep, using the sonypi driver switches the laptop in a pseudo acpi
> mode and APM based suspend will get disabled.
...
> You'll have to wait for ACPI suspend support in the kernel
> (some support will get into the 2.5 kernel series) or choose between
> the sonypi driver and APM suspend.

Patrick Mochel has some patches for ACPI to enable suspend-to-ram
[problems with vesafb nd evices, otherwise ok], and
I'm currently working on suspend-to-disk [will work in easy cases].
See acpi list.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

