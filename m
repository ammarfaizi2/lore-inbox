Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269313AbRGaPVE>; Tue, 31 Jul 2001 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269316AbRGaPUy>; Tue, 31 Jul 2001 11:20:54 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:24279 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S269313AbRGaPUo>; Tue, 31 Jul 2001 11:20:44 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A9A.0054342C.00@d73mta01.au.ibm.com>
Date: Tue, 31 Jul 2001 20:48:18 +0530
Subject: scheduling problem
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I have a apple G4 machine that is dual processor and running SMP kernel. On
the lines of a patch I ceated a module that I use to bind a process to a
processor.

My program creates multiple threads and there are multiple instances of
program running at same time. All the threads/processes are binded to a
single processor. If I boot my machine in non-SMP kernel and run all the
instances of my program, everything works fine. But if I boot my machine in
SMP kernel and run all the instances of my program, I get a timeout
condition from one of the threads regularly but at random intervals of
time. After adding a lot of debugging statements, most probably it scales
down to scheduling problem. I added 'sleep(1)' in all the threads that are
created and everything worked fine. Are there any other methods to debug?
How can I find out the time intervals during which a process was scheduled
out and on which processor it ran on during its lifetime?

Regards,
Daljeet.


