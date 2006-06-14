Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWFNCFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWFNCFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 22:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWFNCFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 22:05:06 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:43742 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S964890AbWFNCFE (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 22:05:04 -0400
Message-Id: <5.1.1.5.2.20060614120412.04756d50@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 14 Jun 2006 12:04:59 +1000
To: linux-Kernel@vger.kernel.org
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Testing the Performance of the Linux kernel 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friends,
Robin Holt,

I have changed the linux 2.4.19 kernel by few lines.

This has been done as part of a large research project in grid computing.

Normal Linux kernel samples the runnable queue and calculate the load 
average as a whole number

I have changed that to calculate load average separately for each login user.
Apart from that there is a new /proc/loadavgus file created to record this 
metrics.

Now I want to do some performance tests and show that this change did not 
have any bad implications on the performance of the kernel.

In fact after the changes we have been using the system very effectively 
yet it is good if I can show that it is still in compliance with the 
standards.

(1) Someone has suggested to run  the tests that are context switching 
heavy, like re-aim7, lmbench.

(2) Also I can run some software tasks and show that there is no change of 
performance of the tasks before and after the change.

I would be keen to ask for your advice on planning few performance tests.

Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia

