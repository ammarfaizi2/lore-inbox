Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269210AbRHGRWQ>; Tue, 7 Aug 2001 13:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbRHGRWG>; Tue, 7 Aug 2001 13:22:06 -0400
Received: from acmey.gatech.edu ([130.207.165.23]:2223 "EHLO acmey.gatech.edu")
	by vger.kernel.org with ESMTP id <S269049AbRHGRVy>;
	Tue, 7 Aug 2001 13:21:54 -0400
Message-Id: <5.1.0.14.2.20010807125043.00a864a0@pop.prism.gatech.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Aug 2001 13:30:14 -0400
To: linux-kernel@vger.kernel.org
From: David Maynor <david.maynor@oit.gatech.edu>
Subject: Encrypted Swap
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recovery of deleted information is a large danger, esp to certain 
government agencies and other people who really care that the information 
the have is never seen, but implementing such features in the kernel seems 
the wrong place to do it. In addition to the swap space, in order to be 
effective, you would need to keep the memory in an encrypted state, as well 
as your disk. Just encrypting your swap would be akin to ssh to a machine, 
telneting to another machine, then sshing to a 3rd machine. Since your 
transfer between machine one and two is in the clear, you entire security 
model at that point is comprised. Just encrypting your swap leaves the info 
vulnerable in other places.
	My suggestion is instead of worrying about the swap space, or the tmp 
space, worry about an entire OS security posture(eg. filesystem, memory, 
boot). So if a machine is stolen or comprised, there is an onion of 
security protecting you, not just one or two things.

David Maynor

