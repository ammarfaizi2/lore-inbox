Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUAWJIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUAWJIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:08:42 -0500
Received: from web8006.mail.in.yahoo.com ([203.199.70.93]:15236 "HELO
	web8006.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S263636AbUAWJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:08:40 -0500
Message-ID: <20040123090838.52019.qmail@web8006.mail.in.yahoo.com>
Date: Fri, 23 Jan 2004 01:08:38 -0800 (PST)
From: Himanshu Ashwani <himanshu_ashwani@yahoo.co.in>
Subject: nfs block size
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to run nfs server on linux kernel running
2.4.20-9 and the max block that I can see in the
kernel source is 8k. So I presume the running kernel
will not go beyond that. I want to increase the size.

The question is: by changing the
#define NFSSVC_MAXBLKSIZE      (8*1024)
in /usr/src/linux-2.4/include/linux/nfsd/const.h to 32
K and recompiling the kernel, will I be able to get
32K block size over UDP or is something else required?
I am not trying TCP for the time being.

Can the nfs server side BLK Size be changed on the
fly?

Or is there no need to compile the entire kernel and I
can do by compiling the nfs module separately or the
nfsd for that purpose.
Is there any other way of testing/finding out ( e.g
nfsstat) what the nfs server is using as the block
size.

Also is it necessary that I compile in the TCP support
for NFS to get higher block sizes available.

-Himanshu

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
