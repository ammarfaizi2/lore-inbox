Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbWLQSLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWLQSLn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWLQSLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:11:43 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:48276 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbWLQSLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:11:42 -0500
Date: Sun, 17 Dec 2006 13:11:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
In-reply-to: <200612142217.44840.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linus Torvalds <torvalds@osdl.org>
Message-id: <200612171311.38763.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <45818E6E.8020505@s5r6.in-berlin.de>
 <200612142217.44840.gene.heskett@verizon.net>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 22:17, Gene Heskett wrote:
>On Thursday 14 December 2006 12:48, Stefan Richter wrote:
>[...]
>
>>(Anyway, that's unrelated to Gene's issues.)
>
>And which I haven't had a chance to check yet, the camera is still in
> the truck and I've been busier than a one legged man in an ass kicking
> contest today.  I did get 2.6.20-rc1 built and its whats running, but
> that is as far as I got, too many other honeydo's.  Tomorrow hopefully.
> If I don't wind up using a backhoe for a divining rod, looking for our
> sewer which is beginning to nag us occasionally.

Stefan, I did get a chance to try it out just now, and while I didn't try 
to capture a 2 hour movie, I did use kino to control the camera playback, 
rewind etc stuff for about 10 minutes and had no problems whatsoever.  
Kino I believe, can only step forward and backwards one frame at a time 
in its edit window as nothing happened when I tried those direct to the 
camera while it was paused.  I even went back and played spastic monkey 
on the controls, but was unable to trigger a segfault exit or any other 
kind of an error.  The only entry in the messages log for all this was:

Dec 17 12:47:13 coyote kernel: WARNING: The dv1394 driver is unsupported 
and will be removed from Linux soon. Use raw1394 instead.

Dec 17 12:47:13 coyote kernel: ieee1394: raw1394: /dev/raw1394 device 
initialized

So whatever was done to the ieee1394 stuffs between 2.6.19 and 2.6.20-rc1 
was a definite, and much appreciated improvement, many thanks to all 
concerned, I probably owe somebody a pint (or more).

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
