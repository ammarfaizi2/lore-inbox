Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269211AbUIRK0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbUIRK0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269179AbUIRK0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:26:25 -0400
Received: from DSL212-235-39-79.bb.netvision.net.il ([212.235.39.79]:56960
	"EHLO localhost") by vger.kernel.org with ESMTP id S269211AbUIRK0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:26:16 -0400
Date: Sat, 18 Sep 2004 14:29:00 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97    
   patch)
Message-ID: <20040918142900.06a9ff96@localhost>
In-Reply-To: <MPG.1bb4d933f584efee9896f0@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se>
	<20040912011128.031f804a@localhost>
	<Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
	<20040914175949.6b59a032@sashak.lan>
	<MPG.1bb164a85e6c9d459896e9@news.gmane.org>
	<20040915035820.1cdccaa5@localhost>
	<MPG.1bb4d933f584efee9896f0@news.gmane.org>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 12:22:05 +0200
Giuseppe Bilotta <bilotta78@hotpop.com> wrote:

> That's it:
> 
> > 0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) 

This is on-board controller.

> OTOH, ALSA in 2.6.5 doesn't like the modem controller:
> 
> > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> > MC'97 1 converters and GPIO not ready (0xff00)
> > intel8x0_measure_ac97_clock: measured 52287 usecs
> > intel8x0: clocking to 48000
> > PCI: Setting latency timer of device 0000:00:1f.6 to 64
> > MC'97 1 converters and GPIO not ready (0xff00)
> 
> and 2.6.7 totally fails on both the audio and modem controller
> 
> > unable to grab IRQ 7
> > Intel ICH: probe of 0000:00:1f.5 failed with error -16
> > unable to grab IRQ 7
> > Intel ICH Modem: probe of 0000:00:1f.6 failed with error -16 

Not sure that last one is ALSA related. As noted in mesg 'request_irq' fails.

> I will try one of the 2.6.9 rcs one of these days and see if I 
> can get things to work.

If not please report a problem here https://bugtrack.alsa-project.org/alsa-bug/,
Or let me know.

Sasha.
