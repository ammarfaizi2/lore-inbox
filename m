Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTIJA1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTIJA1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:27:22 -0400
Received: from gprs150-72.eurotel.cz ([160.218.150.72]:6272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265090AbTIJA1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:27:21 -0400
Date: Wed, 10 Sep 2003 02:27:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux usb mailing list <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Driver model problems in -test5: usb this time
Message-ID: <20030910002709.GG217@elf.ucw.cz>
References: <20030909230118.GF211@elf.ucw.cz> <Pine.LNX.4.44.0309091628000.695-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091628000.695-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The latter two functions do not exist in -test5. It would helpful if you 
> > > tried to reproduce with a virgin -test5. It would be courteous to state 
> > > what patches you applied on top of the virgin -test5 kernel. 
> > 
> > Lot of them, but only "revert to -test3 swsusp" should be important
> > here.
> 
> Then all bets are off. I cannot expect to reproduce the problems until you 
> narrow down which patch causes the problem or verify that it appears on a 
> standard kernel release.

To follow up myself, patch attached to message sent about 5 minutes
ago indeed fixes the oops. [USB still does not survive suspend/resume,
but at least the kernel survives. Probably pm_send_all() stuff needs
to be cleaned up before USB can be fixed.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
