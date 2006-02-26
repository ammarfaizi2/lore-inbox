Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWB0AAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWB0AAH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWB0AAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:00:07 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:30375 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750772AbWB0AAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:00:05 -0500
Message-ID: <440240F8.3010207@vilain.net>
Date: Mon, 27 Feb 2006 12:59:52 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Luke-Jr <luke@dashjr.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
 ;)
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org> <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com> <200602261339.13821.luke@dashjr.org> <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>And what about DVD-RAM drives? Any plans to support those?
>>My [limited] understanding of DVD-RAM drives was that they are basically 
>>removable block devices... you wouldn't need a recording program for that, 
>>you'd use it like a floppy.
> Same goes for DVD+RW. One may want to use it in conjunction with pktcdvd 
> for aligning and command queueing/iosched reasons.

Can I mount a friendly challenge to that idea?

The reason being, I've got a DVD writer that supports DVD-RAM, and 
because I was curious I bought one.  The media is *hard sectored*.  That 
is, you look at the underneath and you see a series of concentric dots, 
each the same angular distance from each other.  I had presumed that 
these are to give the drive something big to key its read/write 
operations on.  Nice, except I don't think the media is compatible with 
a regular DVD drive.

DVD+RW, on the other hand, I just thought was a different surface 
technology (more expensive, higher quality) than DVD-RW.  There is 
nothing to help with the lead-in/lead-out problem that is why you have 
several megabytes of lead-in and lead-out per session on a multi-session 
disc.

But maybe I'm wrong here... if I could use a DVD+RW like a DVD-RAM I'd 
be very happy indeed.

Sam.
