Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUBPPxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBPPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:53:38 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34784 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265784AbUBPPxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:53:35 -0500
In-Reply-To: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
Subject: Re: [LTP] [Announce] Strace Test
To: "dan carpenter" <error27@email.com>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF4AA08477.15BECB93-ON85256E3C.0056DF6E-86256E3C.0056FBB5@us.ibm.com>
From: Robert Williamson <robbiew@us.ibm.com>
Date: Mon, 16 Feb 2004 09:46:10 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 6.0.2CF2 HFB2 IGS HF12D|January
 21, 2004) at 02/16/2004 10:50:11
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is awesome Dan!  I added the directory into the /tools section of the
LTP and it will be included in the next release. Thanks!

-Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Web: http://www.linuxtestproject.org
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

ltp-list-admin@lists.sourceforge.net wrote on 02/15/2004 11:22:57 PM:

> Good evening,
>
> I'm happy to announce the initial public release of
> Strace Test.  I believe Strace Test is the most
> aggressive general purpose kernel tester available.
> Strace Test generally crashes my system within
> 5 minutes (2.6.1-rc2).
>
> Strace Test uses a modified version of strace 4.5.1.
> Instead of printing out information about system calls,
> the modified version calls the syscalls with improper
> values.  A patch and a binary for i386 are included
> in the strace_test tar ball.
>
> Strace Test uses LTP to generate real world syscalls.
> Just unpack ltp and type 'make -k'.  You don't
> need to install the test if you don't want to.
>
> The modifications make the test scripts go haywire.
> To keep the test on track we restart it every 10
> seconds.  The first script is run as root and it
> spawns off the test as a test user.  Every 10 seconds
> root kills off all the test user's processes and
> restarts the test.  The actual tests are run with
> user permissions.
>
> Strace Test is available from:
> http://67.113.20.209/strace_test.tar.bz2
>
> Test Instructions (for i386)
> Create a test user
> Download and untar ltp (ltp.sf.net)
> Cd to ltp and `make -k`
> Untar strace_test
> cd strace_test && ./go_go.sh
> Enter the path to ltp
> Enter the test user
>
> regards,
> dan carpenter
> --
> ___________________________________________________________
> Sign-up for Ads Free at Mail.com
> http://promo.mail.com/adsfreejump.htm
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


