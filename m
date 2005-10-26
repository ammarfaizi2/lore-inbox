Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVJZSSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVJZSSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVJZSSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 14:18:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8832 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964843AbVJZSSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 14:18:25 -0400
Date: Wed, 26 Oct 2005 20:18:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ed Tomlinson <tomlins@cam.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Message-ID: <20051026181809.GD4050@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz> <200510221801.49314.tomlins@cam.org> <20051023083535.GA1975@elf.ucw.cz> <200510230853.14484.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200510230853.14484.tomlins@cam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Transmitted 1000000 bytes in 103.183640 seconds (9.464 kbytes/s)
> > > 
> > > I see about the same with a bluetooth usb adapter.  Suspect that is about what
> > > you should see with bluetooth - its not designed for speed.  It would be really 
> > > nice to be wrong though...
> > 
> > No, it is designed to do more. It should do around ~100 kbytes/sec
> > according to spec, and MSI dongle *does* do 25 kbytes/sec easily
> > against nokia 6230.
> 
> Pavel,
> 
> Then the interesting test is to see if the delay is kernel or phone.   Are you talking
> to the same phone with both adapters?  If so please copy me on any test patches as
> I too have the same issue when talking to a pilot T3 using rfcomm using a "0a12:0001 
> Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" usb dongle.
> 
> I would _love_ to get 25K/s

Yes, I was using same phone (n6230) with MSI and billiontonCF. It gets
25KB/sec with MSI, but only 10KB/sec with billiontonCF.
								Pavel
-- 
Thanks, Sharp!
