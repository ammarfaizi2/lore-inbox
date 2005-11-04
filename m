Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVKDTCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVKDTCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKDTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 14:02:31 -0500
Received: from md2.mail.umd.edu ([128.8.31.175]:5742 "EHLO md2.mail.umd.edu")
	by vger.kernel.org with ESMTP id S1750831AbVKDTCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 14:02:31 -0500
Subject: Something broke suspend/resume between 2.6.11 and 2.6.12/13/14
From: Steve Moskovchenko <stevenm@umd.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 04 Nov 2005 14:02:58 -0500
Message-Id: <1131130978.12842.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I have a Dell 600m x86 laptop here and I am using suspend-to-ram
("suspend"). With kernel 2.6.11, everything works fine for months at a
time- the machine suspends, resumes, there is no problem.

However, kernels 2.6.12, 2.6.13, and 2.6.14 have all exhibited the
following problem: every few days the machine will not resume. I open
the lid, it powers up, hard drive light flashes once or twice, and
nothing else happens. The screen backlight will not even come back on.

This is not an issue with other software on the system. After 2.6.12
refused to resume, I went back to 2.6.11 and everything worked fine
again. When 2.6.13 came out, I built that and again, sometimes it will
not resume. I went back to 2.6.11 again and everything worked fine again
up until I switched to 2.6.14. It worked fine for two days, and now it
too locked up during resume.

I don't want to be stuck on kernel 2.6.11 til the end of time. There
must have been some significant changes between 2.6.11 and 2.6.12 that
introduced this... Does anyone have any ideas? Here is a link to
my .config for 2.6.14 if anyone wants to look at it:
http://wam.umd.edu/~stevenm/config2614

Thanks for the help
-- Steve


