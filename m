Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSDXDAr>; Tue, 23 Apr 2002 23:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSDXDAq>; Tue, 23 Apr 2002 23:00:46 -0400
Received: from f43.law3.hotmail.com ([209.185.241.43]:31497 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S314465AbSDXDAq>;
	Tue, 23 Apr 2002 23:00:46 -0400
X-Originating-IP: [161.69.211.200]
From: "Russ Fink" <russfink@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: structure of ftp.kernel.org, patch dirs
Date: Thu, 18 Apr 2002 13:10:29 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F43O6Nr85kNScMZ3lVR00008888@hotmail.com>
X-OriginalArrivalTime: 24 Apr 2002 00:42:07.0921 (UTC) FILETIME=[DCD46210:01C1EB28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm a linux vet, but am relatively new to kernel compiling.  I'm trying to 
trace a nasty bug, and I wish to build incremental kernels of the 2.2 tree. 
I'm looking at ftp.kernel.org in the v2.2/testing directory, and have a 
question about the directory setup.

Can someone tell me, what is the difference between patches in the "incr" 
directory and patches in the "old" directory?

In pub/linux/kernel/v2.2/testing/incr/ I see files such as:
patch-2.2.19-pre1-pre2.gz

whereas in pub/linux/kernel/v2.2/testing/old/ I see:
patch-2.2.19-pre2.gz

My objective is to start with the latest 2.2.17 sources and patch it up to 
specific levels, e.g., 2.2.18-pre3.  Do I use patches in "incr", or patches 
in "old"?

I'm guessing that "old" patches will take me from 2.2.17 to version
2.2.18-pre-"N" without needing to go through the previous N-1 patches first, 
but that patches in "incr" will only take me from one patch level to the 
next higher level (from 1 to 2, etc).  They appear to be smaller patch 
files.  Is this right?

Thanks for your time,
Russ Fink


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

