Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKHAde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTKGWGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24213 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264328AbTKGNVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 08:21:47 -0500
Date: Fri, 7 Nov 2003 14:21:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test9: suspend no go
Message-ID: <20031107132146.GC20585@atrey.karlin.mff.cuni.cz>
References: <3F9BCF7A.7000403@portrix.net> <20031107100609.GA5088@elf.ucw.cz> <3FAB8CA1.7040105@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAB8CA1.7040105@portrix.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> |>A little contribution to the ongoing suspend saga. This is a Sony Vaio
> |>SRX51P Laptop (P3 Mobile CPU, i820 chipset).
> | Few tips:
> |
> | If you want to trick swsusp/S3 into working, you might want to try:
> |
> | * go with minimal config, turn off drivers like USB you don't really
> | need
> |
> 
> Tried it with minimal config. Base problem is, that after suspending,
> I've no way to wake up the laptop again, but power cycling.

Well, that's expected I believe. You use power button to wake it up...

> That means:
> ~  "mem": after power cycling it is doing a 'normal' reboot. (okay memory
> contents is lost, so this is somewhat expected)

Lets solve S3 later...

> ~  "disk": hey, after power cycling it indeed resumes to the previous
> state. so I tried to compile in some more stuff. What breaks it is AGP
> support :-(. Are there any patches around which may fix this?

No, someone needs to do the work.

> Any idea, why the laptop is not powering on again after suspend? I can
> hold down the power switch as long as I want to, but the laptop doesn't
> do a thing.

Seems like hardware bug? [So you have to remove battery/AC then
poweron?]
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
