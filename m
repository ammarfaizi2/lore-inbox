Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRDBKlQ>; Mon, 2 Apr 2001 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRDBKlG>; Mon, 2 Apr 2001 06:41:06 -0400
Received: from f103.law3.hotmail.com ([209.185.241.103]:47118 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S132667AbRDBKkq>;
	Mon, 2 Apr 2001 06:40:46 -0400
X-Originating-IP: [192.122.134.138]
From: "Destroy micro$oft" <ihate_ms@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.3 instabilities, kernel panic with IrDA, ps, etc.
Date: Mon, 02 Apr 2001 10:40:00 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F103G5aYY61LEdyt3ce00004d5e@hotmail.com>
X-OriginalArrivalTime: 02 Apr 2001 10:40:00.0953 (UTC) FILETIME=[44F56A90:01C0BB61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's with the so called "stable" 2.4.x kernels
these days?

The first time I booted 2.4.3, the system came
up to the login prompt and promptly froze.
The second time, I tried to start X, and it
froze again. Never seen this with the older
kernels.

I've got my actisys IrDA dongle working with
the 2.2.x and 2.4.2 kernels, and tried the
2.4.3 kernel. As soon as a connection was initiated,
I got an Oops, kernel panic, and an Aieeee!
This behaviour was repeated infrequently - it
does this once every 5 connect requests.

With ps -ax | grep something, it complained
about not being able to do something with
file descriptor 1 and 4.

Other than the kernel change from 2.4.2 to
2.4.3, nothing else has been modified in my
system.

BTW I'm using a run of the mill PC with a P-II,
ATI Mach64, sound blaster, Adaptec AIC7880 SCSI,
etc.

The other interesting thing is the code bloat.
Given the exact same options with 2.2.1[789]
the compressed kernel comes to ~510KB. With
2.4.x, it's 730+KB :(  Whoa!

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

