Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVBUWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVBUWIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVBUWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:08:32 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:41389 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262153AbVBUWIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:08:30 -0500
Date: Mon, 21 Feb 2005 17:08:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
In-reply-to: <20050221182952.GF6722@wiggy.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200502211708.27211.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200502211216.35194.gene.heskett@verizon.net>
 <200502211325.55013.gene.heskett@verizon.net> <20050221182952.GF6722@wiggy.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 February 2005 13:29, Wichert Akkerman wrote:
>Previously Gene Heskett wrote:
>> Thats what I was afraid of, which makes using it for a motion
>> detected burgular alarm source considerably less than practical
>> since the machine must be able to do other things too.
>
>Dependin on the type of compression used you might be able to detect
>motion by analyzing the compressed datastream.
>
Its jpg coming out of the camera, but I don't know to capture the raw 
stream and do the comparisons.  One would have to first subtract the 
expected peak values of the sensors noise (snow if you will), either 
by a running average obtained by frame addition on a pixel by pixel 
basis.  Somehow, that seems to imply a decoded stream.  And thats 
obviously not going to be anything but cpu intensive too.  So I'm 
less than enthusiastic that its a workable solution unless one is 
able to dedicate a machine to that job exclusively.  X10 FIR's like 
the EagleEye or HawkEye will need to be used to detect when the 
recording should be started (and stopped)

Many thanks to the responders here.

>Wichert.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
