Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUBWTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUBWTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:47:57 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:30188 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262014AbUBWTrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:47:52 -0500
Date: Mon, 23 Feb 2004 12:50:39 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Message-ID: <20040223195039.GB755@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au> <40395872.2030007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40395872.2030007@gmx.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:33:38AM +0100, Prakash K. Cheemplavam wrote:
> >>Here are some temperatures from my machine read from the bios on reboot.
> >>I gave it minimal activity for the minutes prior to reboot.
> >>
> >>Win98, 47C
> >>XPHome, 42C
> >>Patched Linux 2.4.24 (1000Hz), 40C
> >>Patched Linux 2.6.3-rc1-mm1, 53C  OUCH!
> >
> >Found the problem for 2.6
> >
> >After fixing it the 2.6 temperature is
> >Patched Linux 2.6.3-rc1-mm1, 38C
> >Ambient today is 1C cooler also.
> 
> Well, I hate to say it, but it seems, it doesn't work, or at least not 
> so well, (running hot, but stability seems to be there) with 2.6.3-mm2. 
> Like I had 52?C mostly idle with your patch and APIC just a few moments 
> ago. Now back to PIC within a few minutes I am back to 45?C...7?C is too 
> much of a difference for me.
> 

While on the subject of tempertures,  I found something a bit weird.  In linux 
with C1 disconnects enabled, the system temperature was 36 C.  I rebooted to 
BIOS setup and watched the temperatures there.  For some weird reason, the 
system temperature rose from 36 C, to about 41 C.  And I also watched the CPU 
temp rise from about 41 C to about 51 C !  I boot back into linux, and I watched
the system temperature _drop_ to 36 C again.  What is C1 disconnects disabled 
during POST now on my BIOS?  I have done this before when I first got it and 
never noticed something like this.


Jesse

