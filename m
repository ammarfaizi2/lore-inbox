Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318611AbSGSRLo>; Fri, 19 Jul 2002 13:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318612AbSGSRLo>; Fri, 19 Jul 2002 13:11:44 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:46602 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S318611AbSGSRLn>; Fri, 19 Jul 2002 13:11:43 -0400
Date: Fri, 19 Jul 2002 19:14:45 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch* 1/3] remove 287 unneeded #includes of sched.h (fwd)
Message-ID: <Pine.LNX.4.33.0207191905470.23868-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes 287 occurences of '#include <linux/sched.h>', where 
none of the definitions is actually referenced. In some cases #includes
of files previously pulled in by sched.h are reintroduced to satisfy 
indirect dependencies.

Since some files depend on sched.h being included indirectly anyways,
two more patches are required to make the kernel compile again. 

Tim


The actual patch can be found here:
Part 1/3:
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-10a.patch.gz
Part 2/3:
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-10b.patch.gz
Part 3/3:
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/task_struct.h-06.patch
    

