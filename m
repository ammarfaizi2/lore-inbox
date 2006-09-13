Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWIMAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWIMAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWIMAS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:18:58 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:52407 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1030426AbWIMAS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:18:57 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200609130035.k8D0ZgT7008377@auster.physics.adelaide.edu.au>
Subject: 2.6.17 oops, possibly ntfs/mmap related
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Sep 2006 10:05:42 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a machine which is currently making heavy use of a usb hard disc
formatted with ntfs.  There have been two occasions where the kernel has
oopsed while this disc was being accessed heavily.  Before adding this HDD
the machine in question was rock solid which leads me to think that it
might be related to ntfs.  USB drives formatted with other filesystems do
not appear to suffer from this problem.

Unfortunately bogofilter considers the oops reports as spam so I cannot post
them to the list.  I have instead put the full text of my original post
regarding this topic on the web at

  http://www.atrad.com.au/~jwoithe/kernel/oopses-20060913.txt

I'm happy to try things to narrow down the cause if it will help.

Please CC me on reply.

Regards
  jonathan
