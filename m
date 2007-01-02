Return-Path: <linux-kernel-owner+w=401wt.eu-S932795AbXABKbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbXABKbY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbXABKbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:31:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45511 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932795AbXABKbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:31:23 -0500
Date: Tue, 2 Jan 2007 11:31:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: Suspend problems on 2.6.20-rc2-git1
Message-ID: <20070102103116.GB2122@elf.ucw.cz>
References: <459771A2.6060301@shaw.ca> <200612311427.02175.rjw@sisk.pl> <200612311724.11423.rjw@sisk.pl> <200701020047.02918.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701020047.02918.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Secondly, if you try and suspend manually it claims there is no swap 
> > > > device available when there clearly is:
> > > > 
> > > > [root@localhost rob]# cat /proc/swaps
> > > > Filename                                Type            Size    Used 
> > > > Priority
> > > > /dev/mapper/VolGroup00-LogVol01         partition       1048568 0       -1
> > > > [root@localhost rob]# echo disk > /sys/power/state
> > > > bash: echo: write error: No such device or address
> > > 
> > > Hm, at first sight it looks like something broke the suspend to swap
> > > partitions located on LVM.  For now I have no idea what it was.
> > 
> > _Or_ something broke your initrd setup.
> 
> No, this is a kernel problem, I think.
> 
> Can you please check if the appended patch fixes the issue?

I never liked  someting **, but I guess it is okay in limited form...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
