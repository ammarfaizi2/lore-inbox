Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129470AbRCHTxI>; Thu, 8 Mar 2001 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCHTw7>; Thu, 8 Mar 2001 14:52:59 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:32997 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129470AbRCHTwt>; Thu, 8 Mar 2001 14:52:49 -0500
Importance: Normal
Subject: Kernel stress testing coverage
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF6900214E.F6A2F64E-ON85256A09.006A7125@raleigh.ibm.com>
From: "Paul Larson" <plars@us.ibm.com>
Date: Thu, 8 Mar 2001 13:52:21 -0600
X-MIMETrack: Serialize by Router on D04NMS24/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 03/08/2001 02:52:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for some advice from all of you that know and understand the
Linux kernel so well.  I'm not a kernel developer, but I want to do some
verification work on it, namely stress testing to begin with.  I'm working
on putting together a suite of tests to test the linux kernels under stress
loads for extended runs.  I'll be doing these tests on a mixture of
machines, but most of my focus will be on 2-way, 4-way and 8-way smp
machines.
We've been using some open source tools such as bonnie (for filesystem
stress), but I welcome suggestions for others that will provide good
coverage.  To fill in the gaps, we'll probably be developing our own
testcases.  We have no problems generating mixed loads, and even maxing out
8-way SMP servers for long periods of time, but to be useful, I want to
make sure that whatever tests we are running are getting good coverage of
the kernel code.
Is there any way to see what pieces of the kernel or even percentage we are
hitting with any given test?  I've heard of tools like gcov for doing this
with applications, but the kernel itself seems like it might require
something more.  Are there any ideas you can suggest for writing tests that
will hit as much code as possible in any given section of the kernel like
FS, MM, Scheduler, IPC?  What major sections (like those I previously
mentioned) should I be focused on trying to hit?
All the tests we are writing will be open source of course, and I welcome
any input you may provide.

Thanks,
Paul Larson
Please reply to: plars@us.ibm.com

