Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCLK34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCLK34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVCLK34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:29:56 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:19349 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261342AbVCLK3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:29:54 -0500
Date: Sat, 12 Mar 2005 02:29:52 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: chaffee@bmrc.berkeley.edu
cc: mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CHECKER] crash + fsck cause file systems to contain loops (msdos
 and vfat, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120220190.10643-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We are from the Stanford Checker team and are currently developing a file
system checker call FiSC.  FiSC mainly focuses on finding crash-recovery
errors.  We applied it to FiSC and found a serious error where crash then
recovery cause the file system to contain loops.

To reproduce the warning, download and run our test cases at

http://fisc.stanford.edu/bug7/crash.c (for msdos)
http://fisc.stanford.edu/bug10/crash.c (for vfat)

you can also find the crashed disk images in the corresponding
directories.

We are not sure if these are bugs or not.  Your
confirmations/clarifications on this are well appreciated.

-Junfeng

