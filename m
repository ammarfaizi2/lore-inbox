Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266290AbUGAVd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266290AbUGAVd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUGAVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:33:57 -0400
Received: from postal.ivytech.edu ([168.91.14.3]:39808 "EHLO mail.ivytech.edu")
	by vger.kernel.org with ESMTP id S266290AbUGAVdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:33:54 -0400
Message-ID: <35545.10.0.15.208.1088717634.squirrel@mail.ivytech.edu>
Date: Thu, 1 Jul 2004 16:33:54 -0500 (EST)
Subject: 2.6.x, megaraid, new driver version?
From: "John Madden" <jmadden@ivytech.edu>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the process of eagerly moving my machines to the 2.6 series, I've run
across some intermittent issues with the built-in megaraid2 driver. 
Machines (Dell 2450's with PERC-3's and 1750's with PERC-4Di's) are
hanging with messages like:

megaraid: ABORTING- 345c5 cmd=2a <c=0 t=0 l=0>
megaraid: ABORTING- 345c5[47] fw owner.

...generally under I/O stress.

I see that the driver version is v2.00.3, released in Feb 2003 and that
the later 2.4.x kernels ship with much newer drivers.  Since I'm having no
trouble with the 1.1x driver on the machines that are still 2.4.x-based, I
have to either roll my boxen back to 2.4.26 or stick it out with 2.6.7 and
hope it turns out to be a good day.  I found in the archives mention of a
"unified driver" and I'm assuming that's referring to a single driver
between both kernel trees, but I saw no mention of a tentative release
date, what version of the driver that's to be based on, etc.

So I'm looking for suggestions -- what do I do driver-wise, how can I keep
them running on 2.6.x if possible, how soon before there's a unified
driver release in the mainline kernel, etc.?

Thanks,
  John




-- 
John Madden
UNIX Systems Engineer
Ivy Tech State College
jmadden@ivytech.edu


