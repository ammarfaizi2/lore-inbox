Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTKPQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 11:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTKPQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 11:57:30 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262991AbTKPQ53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 11:57:29 -0500
Date: Sun, 16 Nov 2003 17:57:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix firmware loader docs
Message-ID: <20031116165757.GA201@elf.ucw.cz>
References: <SuZ1.4nW.9@gated-at.bofh.it> <E1ALOz0-0000I5-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ALOz0-0000I5-00@neptune.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AFAICS, sysfs should be mounted on /sys these days...
> > 
> > --- tmp/linux/Documentation/firmware_class/README	2003-08-27 12:00:01.000000000 +0200
> > +++ linux/Documentation/firmware_class/README	2003-11-06 13:50:58.000000000 +0100
> > @@ -60,9 +60,9 @@
> >  
> >  	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
> >  
> > -	echo 1 > /sysfs/$DEVPATH/loading
> > +	echo 1 > /sys/$DEVPATH/loading
> >  	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
> > -	echo 0 > /sysfs/$DEVPATH/loading
> > +	echo 0 > /sys/$DEVPATH/loading
> 
> You need more coffee. You forgot the /sysfs/ on the line with cat. ;)

Heh, maybe thats why it did not work for me ;-).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
