Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292382AbSBUOxb>; Thu, 21 Feb 2002 09:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292396AbSBUOxV>; Thu, 21 Feb 2002 09:53:21 -0500
Received: from starbug.ugh.net.au ([203.31.238.37]:29964 "EHLO
	starbug.ugh.net.au") by vger.kernel.org with ESMTP
	id <S292382AbSBUOxQ>; Thu, 21 Feb 2002 09:53:16 -0500
Date: Fri, 22 Feb 2002 01:53:10 +1100 (EST)
From: David Burrows <snadge@ugh.net.au>
To: linux-kernel@vger.kernel.org
Subject: baffling linux bug / hardware problem
Message-ID: <20020222013558.X11925-100000@starbug.ugh.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a problem where my computer locks up during "Calibrating Delay
Loop..".  I have been using Linux on this same hardware for many years,
and it only started doing this 2 days ago.  It does not seem to matter
what kernel version (2.0, 2.2, 2.4.17) I use or what medium I boot from.

I'd write this off as a hardware problem but both Windows 98 and FreeBSD
4.5 seem to be able to boot and function properly.  I've tried to debug
init/main.c myself and put printks in the loop calibration function.  It
seems to go through the first while loop twice, then hang before getting
to the __delay part.

Could this be a timer interrupt problem?  How do I diagnose this?  Why do
other oses work and Linux (which previously worked fine) no longer does
no matter what version or where I boot it from.

My hardware is p166mmx, intel HX chipset.  I have also tried a memory
tester which says that the memory is fine.  I'm totally stumped.

Any feedback on this problem would be much appreciated.  (CC me direct as
I'm not subscribed to this list).

Thanks in advance,

Dave.

