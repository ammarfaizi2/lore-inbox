Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUGBONb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUGBONb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUGBONa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:13:30 -0400
Received: from mail.mysnip.de ([194.25.82.167]:20141 "EHLO mail.mysnip.de")
	by vger.kernel.org with ESMTP id S264569AbUGBONI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:13:08 -0400
Date: Fri, 2 Jul 2004 16:12:44 +0200
From: Thomas Seifert <thomas-lists@mysnip.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a couple of powernow-k8 questions
Message-Id: <20040702161244.3a3099ed.thomas-lists@mysnip.de>
In-Reply-To: <20040702122652.GA15169@elf.ucw.cz>
References: <20040629223328.68eff5e9.thomas-lists@mysnip.de>
	<20040702122652.GA15169@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

thanks and its solved already.
I got a brand new bios (July 1st ;-)) from my mainboard-manufacturer
which solved the problem. 

My CPU is now running nicely at 32°C.


Regards,

Thomas

On Fri, 2 Jul 2004 14:26:52 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > I'm running an athlon64 3000+ on an epox-mainboard.
> > 
> > after some bios-upgrades through their support I'm getting at least a bit
> > of powernow-support ;)
> > 
> > Through startup I'm getting these messages now:
> > 
> > powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
> > powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
> > powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> > powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> > powernow-k8: cpu_init done, current fid 0xc, vid 0x2
> > ACPI: (supports S0 S1 S4 S5)
> > 
> > 
> > Just to confirm: does that mean only these modes are supported? 
> > Wasn't there something down to 800 MHz for the athlon64-processors?
> 
> I'd say bios problem. Only AMD people know for sure. 
> 
> > Is this a problem of the mainbord (aka still their bios ;)) or of
> > the driver?
> > Any way to workaround this?
> 
> Look into archives for methods how to override.
> 
> 								Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
