Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbTIIXEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTIIXBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:01:47 -0400
Received: from gprs149-34.eurotel.cz ([160.218.149.34]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265034AbTIIXBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:01:30 -0400
Date: Wed, 10 Sep 2003 01:01:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Driver model problems in -test5: usb this time
Message-ID: <20030909230118.GF211@elf.ucw.cz>
References: <20030909122938.GA12450@elf.ucw.cz> <Pine.LNX.4.33.0309090854220.919-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309090854220.919-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Upon attempt to swsusp, I get "Unable to handle kernel paging request
> > at virtual address fffffff4" in usb_device_suspend, called from
> > suspend_device, device_suspend, drivers_suspend, do_software_suspend,
> > ....
> 
> Unfortunately, we don't have a 'taint' flag for when extra patches are 
> added to an official release. 

:-)

> The latter two functions do not exist in -test5. It would helpful if you 
> tried to reproduce with a virgin -test5. It would be courteous to state 
> what patches you applied on top of the virgin -test5 kernel. 

Lot of them, but only "revert to -test3 swsusp" should be important
here.

> The entire Oops would also help, captured either by hand or with e.g. a 
> digital camera. You may want to cc the usb-devel list, too.

Good news is that it only happens when there are devices plugged into
usb. I'll test other machines now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
