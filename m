Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWAZVP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWAZVP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWAZVP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:15:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64236 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964899AbWAZVP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:15:28 -0500
Date: Thu, 26 Jan 2006 22:15:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Larry Finger <Larry.Finger@lwfinger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to dump stack for kernel threads
In-Reply-To: <43D90AB2.3020705@lwfinger.net>
Message-ID: <Pine.LNX.4.61.0601262214430.27891@yvahk01.tjqt.qr>
References: <43D90AB2.3020705@lwfinger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: How to dump stack for kernel threads
>
> In a driver that I am debugging, there is a periodic task that runs every
> minute. Intermittently, it destructively interrupts some other activity in the
> driver, but I have not been able to find the section that is not thread-safe. I
> have included a dump_stack call at the point where the problem is evident, but
> the current thread is OK. How would I generate a stack dump of the rest of this
> driver's kernel threads? Dumping all kernel threads would also be OK.

Sysrq+T. Behind the jungle, there's a function doing what you want.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
