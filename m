Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSBQIIm>; Sun, 17 Feb 2002 03:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292842AbSBQIIW>; Sun, 17 Feb 2002 03:08:22 -0500
Received: from gw.wmich.edu ([141.218.1.100]:46516 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S292841AbSBQIIK>;
	Sun, 17 Feb 2002 03:08:10 -0500
Subject: ext3 fs problem in 2.4.18-rc1?
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 17 Feb 2002 03:08:04 -0500
Message-Id: <1013933289.18783.8.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.18-rc1 with the preempt patch and whenever I run fsck, it
keeps finding more and more errors.  Specifically those related to
corrupted orphan linked lists. I dont know what is going on but I know
it's not the drives because they were all tested before partitioning
under an older (woody's kernel) and everything was fine (bad block
test).  

No matter how many times I run fsck, even immediately after a previous
run, it picks up the same errors along with new ones it seemingly
created in the last run. 

if there is any more information about the problem I can give just say
what's needed. I'd like to get to the bottom of this. 

