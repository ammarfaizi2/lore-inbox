Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbREWGBN>; Wed, 23 May 2001 02:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbREWGAx>; Wed, 23 May 2001 02:00:53 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:45028 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261857AbREWGAo>; Wed, 23 May 2001 02:00:44 -0400
Message-ID: <3B0B533B.B902EE85@wipro.tcpn.com>
Date: Wed, 23 May 2001 11:35:47 +0530
From: "Shashi Kiran T.R." <Shashi.Kiran@wipro.com>
Organization: Wipro Ltd
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Shashi.Kiran@wipro.com
Subject: Kernel memory mapped into user process
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

    I have a proposition at hand to optimize getting system time by
avoiding
the system call(gettimeofday()) overhead. This can be implemented by
keeping a read-only page of kernel memory mapped into user processes
for reading quickly. A kernel process can keep that page up-to-date.

   I did some browsing of this mailing list archives to get the
following related
topics:
*  mapping user space buffer to kernel address space
* Direct I/O
* Zero Copy IO
  None of these seem to specifically address my problem.

So can the experienced please throw some light on the issues involved
in having a read-only page of kernel memory mapped into user process.
Any help/suggestions will be much appreciated. Please CC your comments
to "trsk@wipro.tcpn.com"

Thanks and Regards,
  Shashi

