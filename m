Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVIGKpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVIGKpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIGKpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:45:49 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:15772 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751175AbVIGKpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:45:49 -0400
Date: Wed, 7 Sep 2005 12:45:40 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Valdis.Kletnieks@vt.edu
Cc: "Budde, Marco" <budde@telos.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: <200509070958.j879w4p0017726@turing-police.cc.vt.edu>
Message-Id: <Pine.OSF.4.05.10509071243410.21532-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 07 Sep 2005 11:13:24 +0200, "Budde, Marco" said:
> 
> > E.g. in my case the Windows source code has got more than 10 MB.
> > Nobody will convert such an amount of code from C++ to C.
> > This would take years.
> 
> Do you have any *serious* intent to drop 10 *megabytes* worth of driver
> into the kernel??? (Hint - *everything* in drivers/net/wireless *totals*
> to only 2.7M).
> 

For a special perpose embedded application, doing it all in kernel space
would be the first, effective hack. 

> A Linux device driver isn't the same thing as a Windows device driver - much of
> a Windows driver is considered "userspace" on Linux, and you're free to do that
> in C++ if you want.
> 

Yes, moving stuff to user-space would be the way to go - unless it kills
performance! 

Esben

