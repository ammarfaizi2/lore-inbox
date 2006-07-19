Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWGSPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGSPKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGSPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:10:05 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:22452 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S964865AbWGSPKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:10:04 -0400
Message-ID: <44BE4B33.6090009@cmu.edu>
Date: Wed, 19 Jul 2006 11:09:39 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Jeff Chua <jchua@fedex.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <44BCFDA6.3030909@cmu.edu> <200607190005.02351.rjw@sisk.pl>
In-Reply-To: <200607190005.02351.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I was missing that, thanks

So, i suspended to disk the first time and it seemed to suspend
properly, then I hit the power button on the thinkpad and it took me to
the thinkpad screen, back to grub, and booted the OS from the beginning.
 Did I resume the wrong way?

So, after it rebooted, i tried to suspend it to disk again:
x60s gnychis # echo platform > /sys/power/disk; echo disk > /sys/power/state
bash: echo: write error: No such device

So now it won't even suspend to disk.

Any ideas?

Thanks!
George


Rafael J. Wysocki wrote:
> On Tuesday 18 July 2006 17:26, George Nychis wrote:
>> acpid has been started, however there is no /sys/power/disk
> 
> Have you set CONFIG_SOFTWARE_SUSPEND in .config?
> 
> Rafael
> 
