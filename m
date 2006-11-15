Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161977AbWKOWUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161977AbWKOWUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161982AbWKOWUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:20:06 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:59575 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161977AbWKOWUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:20:04 -0500
Date: Wed, 15 Nov 2006 23:19:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hasso Tepper <hasso@estpak.ee>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sysctl syscall
In-Reply-To: <200611160003.02681.hasso@estpak.ee>
Message-ID: <Pine.LNX.4.61.0611152317120.12683@yvahk01.tjqt.qr>
References: <200611160003.02681.hasso@estpak.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 16 2006 00:03, Hasso Tepper wrote:
>
>Compiling the program which uses a lot "sysctl" syscalls, gives me this 
>warning on Debian unstable:
>
>"warning: the `sysctl' syscall has been removed from 2.6.18+ kernels, 
>direct access to `/proc/sys' should be used instead."
>
>Is it true?

Well it was unobsoleted in 2.6.19 if I followed the list correctly.

>And what can be used as alternative which would work with both 
>2.4 and 2.6 kernels
>and would work with capabilities (sys/capability.h)?
>Accessing `/proc/sys' directly isn't such alternative as it doesn't work 
>with capabilities.



	-`J'
-- 
