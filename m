Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277281AbRJJPqJ>; Wed, 10 Oct 2001 11:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277284AbRJJPp6>; Wed, 10 Oct 2001 11:45:58 -0400
Received: from smtp-out.student.liu.se ([130.236.230.80]:20577 "EHLO arcadia")
	by vger.kernel.org with ESMTP id <S277281AbRJJPpu>;
	Wed, 10 Oct 2001 11:45:50 -0400
Date: Wed, 10 Oct 2001 17:46:05 +0200 (CEST)
From: Erik Gustavsson <cyrano@algonet.se>
Subject: 2.4.10-acX VM troubles
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.21.0110101727070.777-100000@lillan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first I thought that the VM in 2.4.10-acX (I've tried ac3 and ac7) was
a big improvement over vanilla 2.4.9 (my previous kernel). But after
playing around with different versions and patches, and actually running
the same kernel for a day or more I ran into severe problems. 

The problem can be triggered by a number of things, ususally involving
semi-heavy disk activitity (kernel recompile, apt-get installs...). It
seems to only happen after the system has been up for a while (10+
hours).

Suddenly the CPU usage jumps to 100%, and the load avarage to 10 or
more. The system becomes completely unresponsive, even the mouse pointer
freezes for long periods of time. It looks like most of the CPU time is
spent in kswapd, and some in kupdated. The harddisk LED shows almost no
activity. 

I haven't verified (yet) that this is -acX only, but vanilla 2.4.9 did not
have this problem.

System is a Duron on KT133 chipset, 256M RAM, 300M swap, reiserfs.

/cyr

-----------------------------------------------------------------------
Cat: Come on bud, you're not doing anything I wouldn't do.
Rimmer: What? You'd sacrifice your life for the sake of the crew?
Cat: No, I'd sacrifice *your* life for the sake of the crew.

