Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbRDCNKN>; Tue, 3 Apr 2001 09:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRDCNKD>; Tue, 3 Apr 2001 09:10:03 -0400
Received: from p18-max2.adl.ihug.com.au ([203.173.184.210]:50192 "EHLO
	ocdi.sb101.org") by vger.kernel.org with ESMTP id <S131709AbRDCNJx>;
	Tue, 3 Apr 2001 09:09:53 -0400
Date: Tue, 3 Apr 2001 22:38:41 +0930 (CST)
From: Trevor Nichols <ocdi@ocdi.org>
X-X-Sender: <data@ocdi.sb101.org>
To: <linux-kernel@vger.kernel.org>
Subject: uninteruptable sleep
Message-ID: <Pine.BSF.4.33.0104032217220.60098-100000@ocdi.sb101.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since upgrading to the latest stable (2.4.3) kernel, I've noticed that
randomly some processes are going into an uninteruptable sleep and not
waking up at all.

It's happened to nautilus and today just happened to mozilla also.
Another common related problem is the load averages go up to n + "normal"
where n is the number of processes that have gone uninteruptable sleep.
This is making me think it's a kernel related problem.

I had one time where nautilus with 9 [presumably forked] processes of
itself go this way, causing load averages to go 9+, however the system
doesn't appear to be straining or strugling under that much load.

The previous kernel version that I was using (2.4.1) did not have this
problem.

One last thing, if this turns out to be a non-kernel problem, the
processes that *do* get stuck, are unkillable - even by root with SIGKILL.
Is there any way for it to be able to? :)  So far I have to reboot each
time it happens.


Best regards,
Trevor Nichols.


ps please CC replies to my address. thanks.

