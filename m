Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUB1AX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbUB1AUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:20:15 -0500
Received: from hell.org.pl ([212.244.218.42]:8979 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263234AbUB1AS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:18:27 -0500
Date: Sat, 28 Feb 2004 01:18:30 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: APM suspend causes uninterruptible sleep
Message-ID: <20040228001830.GA27828@hell.org.pl>
References: <1tLo4-3qF-9@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1tLo4-3qF-9@gated-at.bofh.it>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Keith Duthie:
> Between alsa-driver 0.9.4 and alsa-driver 0.9.5 the change below was made.
> Since then, suspending with a program outputting to the pcm device
> causes that program to enter the uninterruptible sleep state. Reverting
> this patch fixes the problem. The problem exists in 0.9.5 through 1.0.2c.

Just FYI: a similar problem was introduced in intel8x0, also around that
time. Note: the uninterruptible sleep issue only applies to the software
using native ALSA, OSS emulation users seem to survive the suspend.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
