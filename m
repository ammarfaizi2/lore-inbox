Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJWMw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJWMw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 08:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVJWMw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 08:52:58 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:13253 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750711AbVJWMw5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 08:52:57 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Date: Sun, 23 Oct 2005 08:53:13 -0400
User-Agent: KMail/1.8.2
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
References: <20051022173152.GA2573@elf.ucw.cz> <200510221801.49314.tomlins@cam.org> <20051023083535.GA1975@elf.ucw.cz>
In-Reply-To: <20051023083535.GA1975@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510230853.14484.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 October 2005 04:35, Pavel Machek wrote:
> > > Transmitted 1000000 bytes in 103.183640 seconds (9.464 kbytes/s)
> > 
> > I see about the same with a bluetooth usb adapter.  Suspect that is about what
> > you should see with bluetooth - its not designed for speed.  It would be really 
> > nice to be wrong though...
> 
> No, it is designed to do more. It should do around ~100 kbytes/sec
> according to spec, and MSI dongle *does* do 25 kbytes/sec easily
> against nokia 6230.

Pavel,

Then the interesting test is to see if the delay is kernel or phone.   Are you talking
to the same phone with both adapters?  If so please copy me on any test patches as
I too have the same issue when talking to a pilot T3 using rfcomm using a "0a12:0001 
Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" usb dongle.

I would _love_ to get 25K/s

Thanks,

Ed Tomlinson
