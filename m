Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRDEHC6>; Thu, 5 Apr 2001 03:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132566AbRDEHCt>; Thu, 5 Apr 2001 03:02:49 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:38148 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S132564AbRDEHCh>; Thu, 5 Apr 2001 03:02:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Stuck: What to do with solid locks?
Reply-To: klink@clouddancer.com
Date: Wed, 04 Apr 2001 23:42:21 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Message-Id: <20010405070150.03E8C689E@mail.clouddancer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In kernel.list, you wrote:
>
>Oh, I realize this.  I don't mind and even expect the occational crash
>right now in the 2.4.x series, but the frequency of these crashes fall

Well, you say this, but
...more whinny post deleted...

>to begin to help fix this problem (or these problems).

Twice your tone plays different from your words.  A scan of lkml
should have shown you that your problem is not a major problem, it's
far more likely to be unique than general.

- -------------------------------------------------------

1) try a different distribution, RH is bleeding edge at times and the
problems may not be entirely within the kernel.  For example,
Slackware-current is a base (without any additions it runs a 2.4
kernel) I've used with 4 machines now, and the only problem was the
loopback fs hang of a month ago.

2) remove drivers & hardware goodies to see if stability improves.
change your typical application load to see what happens.  I actually
do this the other way, run a simple kernel and then add to it.

3) there are a lot of 2.4 kernels, over 40 variants, look thru the
ChangeLogs, maybe your hardware is mentioned someplace.  try them to
see if stability improves.


In short, try the reduce the possible areas for a bug, ideally getting
to a point where you can state : 2.4.X-Y with AAA locks while 2.4.X-Y
without AAA does not lock.  That will bring more attention.

oh, and

4) boot into your last working kernel when you want to accomplish
something.
