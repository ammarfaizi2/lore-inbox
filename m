Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSKWSu0>; Sat, 23 Nov 2002 13:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKWSuZ>; Sat, 23 Nov 2002 13:50:25 -0500
Received: from [61.11.237.102] ([61.11.237.102]:48133 "HELO
	cse-qmail.cse.iitkgp.ernet.in") by vger.kernel.org with SMTP
	id <S267019AbSKWSuZ>; Sat, 23 Nov 2002 13:50:25 -0500
Date: Sun, 24 Nov 2002 00:27:27 +0530 (IST)
From: "Sathyanarayana.A.N - 01cs6002" <san@cse.iitkgp.dhs.org>
X-X-Sender: <san@pcs-2.cse.iitkgp.ernet.in>
To: <linux-kernel@vger.kernel.org>
Subject: insmod 
Message-ID: <Pine.LNX.4.33L2.0211240020330.16811-100000@pcs-2.cse.iitkgp.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friends,


    I have written a kernel Virtual file system which merges different
filesystem directories. For this I am using a VFS function
inode_dir_notify() function to notify the parent inodes. Now I want my
virtual file system to be converted as a module. I am facing problems
while inserting the module. When I do a insmod it is giving
Unresolved symbol inode_dir_notify even though it is defined in the kernel
VFS. It is working in case of statically linked version.

Can somebody please suggest me why this is happening?

Please CC the reply to san@cse.iitkgp.dhs.org

Thanks and regards,
sathya

