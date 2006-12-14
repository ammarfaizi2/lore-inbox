Return-Path: <linux-kernel-owner+w=401wt.eu-S932861AbWLNQhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWLNQhF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932850AbWLNQhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:37:05 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:41185 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863AbWLNQhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:37:03 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Ben Collins <ben.collins@ubuntu.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <45816981.8010702@superbug.co.uk>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	 <4580E37F.8000305@mbligh.org> <1166105545.6748.212.camel@gullible>
	 <45816981.8010702@superbug.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 11:36:44 -0500
Message-Id: <1166114204.6748.259.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 15:10 +0000, James Courtier-Dutton wrote:
> Ben Collins wrote:
> > 
> > Here's the list of proprietary drivers that are in Ubuntu's restricted
> > modules package:
> > 
> > 	madwifi (closed hal implementation, being replaced in openhal)
> > 	fritz
> > 	ati
> > 	nvidia
> > 	ltmodem (does that even still work?)
> > 	ipw3945d (not a kernel module, but just the daemon)
> > 
> 
> More items will be added to that list soon.
> E.g. Linux Binary only, Creative X-Fi sound card drivers for Q2 2007.
> http://opensource.creative.com/

I haven't even caught wind of this not being supported yet. No demand ==
no reason to include it when it does become available.

> > In over a year that list has only grown by ipw3945d. None of our users
> > are asking for new proprietary drivers. Believe me, if they needed them,
> > I'd hear about it. We have more cases of new unsupported hardware than
> > we do of new hardware with binary-only drivers. This proposed
> > restriction doesn't fix that.
> 
> Is there a list of "new unsupported hardware" ?
> Reverse engineering or datasheets is the only way out of that.
> As Linux becomes more and more popular on the desktop, manufacturers 
> will start feeling the pain of Linux "unsupported hardware" and have to 
> back down and release datasheets. Ubuntu is helping a lot in that direction.

I've not kept a list. Would be non-trivial to go through the bug tracker
to find this info. Mostly it's things like webcams, and wacky little
hardware that starts cropping up in laptops.

> > 
> > You know what I think hurts us more than anything? You know what
> > probably keeps companies from writing drivers or releasing specs? It's
> > because they know some non-paid kernel hackers out there will eventually
> > reverse engineer it and write the drivers for them. Free development,
> > and they didn't even have to release their precious specs.
> 
> Well, once a device has been reverse engineered and GPLed, the specs are 
> then in public domain and the IP does not exist any more. It actually 
> helps the company release the specs once the information is already out 
> there. The company then sees less reason to hold onto their specs in the 
> first place, and tends to release them earlier next time.

Right, I think reverse engineering does help in that aspect. The other
aspect is that they now have a driver that sort of works for their
hardware. Most of the work is done, and they decide to help things along
to make it stable. So laying ground work like this can have advantages.

I think hardware vendors are a lot like users. Once they see the
advantages to opening up their drivers, they wonder why they didn't do
it a long time ago. Sort of like how users need that one push to use
Linux, and they start to wonder why they should go back to Windows.

