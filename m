Return-Path: <linux-kernel-owner+w=401wt.eu-S932792AbWLNPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbWLNPLM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWLNPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:11:12 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:3256 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932792AbWLNPLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:11:11 -0500
Message-ID: <45816981.8010702@superbug.co.uk>
Date: Thu, 14 Dec 2006 15:10:57 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Ben Collins <ben.collins@ubuntu.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>	 <20061214005532.GA12790@suse.de>	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>	 <4580E37F.8000305@mbligh.org> <1166105545.6748.212.camel@gullible>
In-Reply-To: <1166105545.6748.212.camel@gullible>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> Here's the list of proprietary drivers that are in Ubuntu's restricted
> modules package:
> 
> 	madwifi (closed hal implementation, being replaced in openhal)
> 	fritz
> 	ati
> 	nvidia
> 	ltmodem (does that even still work?)
> 	ipw3945d (not a kernel module, but just the daemon)
> 

More items will be added to that list soon.
E.g. Linux Binary only, Creative X-Fi sound card drivers for Q2 2007.
http://opensource.creative.com/

> In over a year that list has only grown by ipw3945d. None of our users
> are asking for new proprietary drivers. Believe me, if they needed them,
> I'd hear about it. We have more cases of new unsupported hardware than
> we do of new hardware with binary-only drivers. This proposed
> restriction doesn't fix that.

Is there a list of "new unsupported hardware" ?
Reverse engineering or datasheets is the only way out of that.
As Linux becomes more and more popular on the desktop, manufacturers 
will start feeling the pain of Linux "unsupported hardware" and have to 
back down and release datasheets. Ubuntu is helping a lot in that direction.

> 
> You know what I think hurts us more than anything? You know what
> probably keeps companies from writing drivers or releasing specs? It's
> because they know some non-paid kernel hackers out there will eventually
> reverse engineer it and write the drivers for them. Free development,
> and they didn't even have to release their precious specs.

Well, once a device has been reverse engineered and GPLed, the specs are 
then in public domain and the IP does not exist any more. It actually 
helps the company release the specs once the information is already out 
there. The company then sees less reason to hold onto their specs in the 
first place, and tends to release them earlier next time.

> 
> Don't get me wrong, I'm not bashing reverse engineering, or writing our
> own drivers. It's how Linux got started. But the problem isn't as narrow
> as people would like to think. And proprietary code isn't a growing
> problem. At best, it's just a distraction that will eventually go away
> on it's own.
> 

I agree, as time goes by, more and more devices are reverse engineered 
or the manufacturer finally sees sense and releases the specs/datasheets.


James
