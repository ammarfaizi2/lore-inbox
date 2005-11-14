Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVKNGDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKNGDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 01:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKNGDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 01:03:36 -0500
Received: from [59.181.96.147] ([59.181.96.147]:6272 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750833AbVKNGDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 01:03:35 -0500
Subject: prob with 2.6 Makefile
From: Sapna Todwal <sapna@neoaccel.com>
Reply-To: sapna@neoaccel.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Neoaccel India Pvt. Ltd
Message-Id: <1131948242.3168.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Mon, 14 Nov 2005 11:34:02 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few doubs with the 2.6 makefile
Suppose I have the following dir structure:
		maindir
		    |
		-------
		|       |
	       subdir1 subdir2

Now both of this subdirs have many .c files which are to be compiled and
linked together to make final1.o & final2.o files in the subdirs
subdir1  & subdir2 respectively.

Now i want to link this two files subdir1/final1.o & subdir2/final2.o ,
in the maindir to make file say final.o file in maindir .

So the Makefile in maindir looks like:

obj-m := subdir1/ subdir2/

This will traverse the subdir1 & subdir2 and call their makefiles.
But how do i make final.o from subdir1/final1.o and subdir2/final2.o

Kindly help me with the solution.

Thanks in advance,
Regards,
Sapna


