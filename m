Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRHMTSG>; Mon, 13 Aug 2001 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268902AbRHMTR4>; Mon, 13 Aug 2001 15:17:56 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:2825 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S268996AbRHMTRl>;
	Mon, 13 Aug 2001 15:17:41 -0400
Message-Id: <200108132033.PAA03688@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.45-2.4.8
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 15:33:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.8 is available.

A number of bugs are fixed, including
	a rerun of the TASK_UNINTERRUPTIBLE deadlock
	hostfs writes now go through the page cache
	crash if an interface tries to get an ether address without 
	having an IP address
	hostfs ls didn't work on 2.4 hosts
	gprof support didn't work with various versions of gcc because of
	various gcc bugs
	the pid file didn't always contain the right pid
	
In other news,
	the ppc port is now completely merged
	all UML configure options now have documentation
	ethertap eth devices can have their addresses changed on the fly
	and the host configuration will follow the change 

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://sourceforge.net/project/showfiles.php?group_id=429
	ftp://ftp.nl.linux.org/pub/uml/
	http://uml-pub.ists.dartmouth.edu/uml/

				Jeff


