Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966565AbWKOAy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966565AbWKOAy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966561AbWKOAyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:54:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966565AbWKOAyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:54:54 -0500
Date: Wed, 15 Nov 2006 00:54:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Miguel Ojeda <maxextreme@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       Jamey Hicks <jamey.hicks@hp.com>
Subject: Re: ACPI output/lcd/auxdisplay mess
In-Reply-To: <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, we were aware of video/backlight/* (read below). Anyway,
> auxdisplay doesn't create a class; it did in first versions, but right
> now it behaves just like a framebuffer, no classes in the playground
> (maybe you read a old version?).
...
> However, auxdisplay means "auxiliary display device drivers", not _the
> display_. In such folder we can put every
> auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
> ...) who has special requirements (like parport wiring, fixed refresh
> rate, different properties...). Also, things like "set_contrast",
> "max_constrast", "set_power"... didn't seem very appropriate.

Is it a framebuffer device ? The framebuffer layer is abstracted to work 
with such devices.
