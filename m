Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262833AbREVVL5>; Tue, 22 May 2001 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbREVVLr>; Tue, 22 May 2001 17:11:47 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:47113 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S262827AbREVVLo>;
	Tue, 22 May 2001 17:11:44 -0400
Message-ID: <25369470B6F0D41194820002B328BDD2071790@ATLOPS>
From: Bharath Madhavan <bharath_madhavan@ivivity.com>
To: linux-kernel@vger.kernel.org
Subject: Speeding up VFS using HW assist
Date: Tue, 22 May 2001 17:11:37 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	I will be using Linux as the OS for an embedded system.
I was looking into 2.4.4 kernel code and saw the dcache implementation
in VFS which is pretty neat and fast by itself.

My question is, will I gain any considerable efficiency in file system
access
if I can move this "pathname -> inode" lookup into some proprietery 
HW assist mechanism and take out the dcache hashing and "cached_lookup"
function.

How good(bad) was it before the dcache implementation and in which release
was dcache feature added (was it only after 2.2.x release). 
Did we get 2-3 times better performance with dcache? (if not, how much?)

Can anyone suggest any other place in the file system (VFS and EXT2) where
we
can use any HW assist (let us say FPGA implementing search, lookup, etc.)
to speed up file-system access (both for opening and read/write)

Would tweaking the buffer cache and page cache sizes make a considerable 
effect on efficiency?

Any other suggestions?

Thanks a lot,

Bharath
