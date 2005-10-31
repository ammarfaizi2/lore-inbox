Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVJaPpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVJaPpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVJaPpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:45:55 -0500
Received: from tim.rpsys.net ([194.106.48.114]:30598 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964776AbVJaPpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:45:55 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051031134255.GA8093@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 15:45:30 +0000
Message-Id: <1130773530.8353.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> This is what I needed to do after update to latest linus
> kernel. Perhaps it helps someone. 
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> , but it is against Richard's tree merged into my tree, so do not
> expect to apply it over mainline. Akita code movement is needed if I
> want to compile kernel without akita support...

This is an update of my tree against 2.6.14-git3:

http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0.patch.gz

I realise a number of the tosa and ipaq drivers are no longer in sync
with the recent changes in mainline but the other drivers all should be
and cxx00 and c7x0 should work.

This has some interesting alpha code from various places including ALSA
SoC code from Liam Girdwood (I've added a wm8750 codec driver to this
which sort of works on cxx00) and framebuffer console rotation from
Antonino Daplas.

A suitable defconfig is:

http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0-defconfig-cxx00

This adds compiles console rotation support into the kernel and enables
it on the commandline. Let Antonino know how much nicer the device is
with this :) 

Cheers,

Richard

