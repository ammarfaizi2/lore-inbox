Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWB0Su3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWB0Su3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWB0Su2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:50:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:659 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751578AbWB0Su2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:50:28 -0500
Date: Mon, 27 Feb 2006 19:50:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Vilain <sam@vilain.net>
cc: Luke-Jr <luke@dashjr.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
 ;)
In-Reply-To: <440240F8.3010207@vilain.net>
Message-ID: <Pine.LNX.4.61.0602271946470.13987@yvahk01.tjqt.qr>
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org>
 <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
 <200602261339.13821.luke@dashjr.org> <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr>
 <440240F8.3010207@vilain.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > And what about DVD-RAM drives? Any plans to support those?
>> > My [limited] understanding of DVD-RAM drives was that they are
>> > basically removable block devices... you wouldn't need a recording
>> > program for that, you'd use it like a floppy.
>> Same goes for DVD+RW. One may want to use it in conjunction with pktcdvd
>> for aligning and command queueing/iosched reasons.
>
> Can I mount a friendly challenge to that idea?
>
I win, reiserfs on a dvd+rw:
  http://jengelh.hopto.org/GFX/dvdrw_r3mnt.jpg

> I had presumed that these are to give the drive
> something big to key its read/write operations on.  Nice, except I don't think
> the media is compatible with a regular DVD drive.
>
Yes. A 650 MB *CD*-RW (DVD-RW too?) formatted in packet mode only has like
500-something megabytes to allow for the sort of seeks required.
On DVD+RW, you get the full 4.3 GB (4.7 gB) AFAICS.

> DVD+RW, on the other hand, I just thought was a different surface technology
> (more expensive, higher quality) than DVD-RW.  There is nothing to help with
> the lead-in/lead-out problem that is why you have several megabytes of lead-in
> and lead-out per session on a multi-session disc.
>
> But maybe I'm wrong here... if I could use a DVD+RW like a DVD-RAM I'd be very
> happy indeed.
>
> Sam.
>
>

Jan Engelhardt
-- 
