Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDOAy0>; Sat, 14 Apr 2001 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDOAyR>; Sat, 14 Apr 2001 20:54:17 -0400
Received: from mail.gator.com ([63.197.87.182]:5134 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132561AbRDOAyM>;
	Sat, 14 Apr 2001 20:54:12 -0400
From: "George Bonser" <george@gator.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 stable when?
Date: Sat, 14 Apr 2001 17:56:03 -0700
Message-ID: <CHEKKPICCNOGICGMDODJKENICLAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a web server farm that right now has about 125 apache processes
running per machine. If I try to use 2.4.3 or even 2.4.3-ac6 it will go to
about 400 (meaning it is slow in clearing connections), the load average
will start to climb until it gets to close to 100 and then stops responding.
It runs ok for about the first 5 minutes of its life and then sinks deeper
and deeper into the mire until it disappears. No processes are shown stuck
in D state.

2.4.4pre3 works, sorta, but is very "pumpy". The load avg will go up to
about 60, then drop, then climb again, then drop. It will vary from very
sluggish performance to snappy and back again to sluggish.

With 2.2 kernels I see something like this:

 00:48:00 up  4:51,  1 user,  load average: 0.00, 0.02, 0.06

141 processes: 139 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   2.8% user,   3.2% system,   0.0% nice,  94.1% idle

and that is with about 120 remote users connected to the box via apache.


Is there any information that would be helpful to the kernel developers that
I might be able to provide or is this a known issue that is currently being
worked out?



