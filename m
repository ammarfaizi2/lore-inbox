Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272494AbTGZO3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272495AbTGZO3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:29:45 -0400
Received: from [65.244.37.61] ([65.244.37.61]:22381 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S272494AbTGZO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:29:36 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920234CD64@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "'Felipe Alfaro Solana'" <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: kernel@kolivas.org, mingo@elte.hu
Subject: RE: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sat, 26 Jul 2003 10:44:19 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Felipe Alfaro Solana [mailto:felipe_alfaro@linuxmail.org]
> Sent: Saturday, July 26, 2003 5:31 AM
> 
> Hi, everyone,
> 
> In first place, let me publicly thanks both of you (Info and Con) for
> your great work at fixing/tuning the 2.6 scheduler to its best.
> 
> Now that Ingo seems to be working again on the scheduler, I feel that
> Con and Ingo work is starting to collide. I have been testing Con's
> interactivity changes to the scheduler for a very long time, 
> since it's
> first O1int patch and I must say that, for my specific workloads, it
> gives me the best end-user experience with interactive usage.
[snip]

Second the thanks.

I don't see much subjective difference between test1-mm(x) and
test1-G2.  I've never gotten an audio skip anyway. The only
skipping I can get is video only skips under xine, but the audio
doesn't skip.

I guess this may be in part due to how I load the machine.  Any
meaningful comparison of the two bodies of work would have to
be made with (at a minimum) a standard set of loads.

The way I loaded my machine (dual Xeon HT) to > 9 load average
was: 1. continuous loop 'ps -ef', 2. KDE make -j8, 3. pov-ray
rendering, 3. continuous bitmap operations in X.

What I've left to date is (among others): 1. heavy disk i/o load,
2. heavy network load, 3. deliberate memory torture.

Operations such as new terminal window, new browser, new Konquerer
etc, are slower of course, and somewhat jerky, but given a load
of 9, even Mozilla and Konquerer loaded in < 15 seconds, a new
terminal loaded and accepted keyboard input in less than 3.

So I wonder if the seemingly disparate results are weirdness,
or are they a combination of basic machine variations coupled
with loading variations?
