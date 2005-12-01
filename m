Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVLAO75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVLAO75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLAO75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:59:57 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:22941 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932260AbVLAO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:59:56 -0500
Date: Thu, 01 Dec 2005 09:59:05 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Gene's pcHDTV 3000 analog problem
In-reply-to: <438E7552.5050505@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>, Don Koch <aardvark@krl.com>,
       kirk.lapray@gmail.com, video4linux-list@redhat.com, CityK@rogers.com,
       perrye@linuxmail.org
Message-id: <200512010959.05865.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200512010320.jB13KoH4009443@p-chan.krl.com> <438E7552.5050505@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 November 2005 23:00, Michael Krufky wrote:
cvs up -D 2005-10-15
was done inside the checkouts v4l-dvb dir
make (in the v4l subdir) clean, ok
make then blows up with:
root@coyote v4l]# make
make -C /lib/modules/2.6.14.3/build SUBDIRS=/usr/src/v4l-dvb/v4l modules
make[1]: Entering directory `/usr/src/linux-2.6.14.3'
make[2]: *** No rule to make target `/usr/src/v4l-dvb/v4l/video-buf.c',
needed by `/usr/src/v4l-dvb/v4l/video-buf.o'.  Stop.
make[1]: *** [_module_/usr/src/v4l-dvb/v4l] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.14.3'
make: *** [default] Error 2

So what I figured to be a good starting point isn't.
  
So I stepped back to the parent v4l-dvb dir, and did a 
cvs up -D 2005-11-1, which updated a whole bunch of stuff, and then I
get this:
[root@coyote v4l-dvb]# cd v4l
[root@coyote v4l]# make clean
.version:1: *** missing separator.  Stop.
[root@coyote v4l]# make
.version:1: *** missing separator.  Stop.

So it looks as if I don't know what I'm doing (and I obviously don't)
Where am I losing it here?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

