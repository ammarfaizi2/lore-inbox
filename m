Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281251AbRKERfy>; Mon, 5 Nov 2001 12:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281256AbRKERfo>; Mon, 5 Nov 2001 12:35:44 -0500
Received: from rain.CC.Lehigh.EDU ([128.180.39.20]:43672 "EHLO
	rain.CC.Lehigh.EDU") by vger.kernel.org with ESMTP
	id <S281251AbRKERfb>; Mon, 5 Nov 2001 12:35:31 -0500
Message-ID: <3BE6C909.6070308@Lehigh.EDU>
Date: Mon, 05 Nov 2001 12:14:49 -0500
From: Jim Eshleman <jce0@Lehigh.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jason Allen <jallen@fnal.gov>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.13 Mem Related Hangs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > We have a 8 CPU/8GB Dell 8450 running 2.4.13 (NFS and XFS patches)
 > which hangs regularly.
 >
 > I'd say that the problem is memory related. What seems to occur is
 > that mem cache grows until physical mem is exhausted at which time
 > the system hangs.

   FWIW me too, on an 8-way 8.5GB (64GB HIGHMEM enabled) IBM Netfinity 
x370 (8500R) which functions as a production mail server.  I currently 
run 2.4.9 with XFS and it stays up for about a week under heavy load. 
2.4.13 lasted about 4 hours under light load until all memory was 
consumed by cache then it became unresponsive.

   2.4.13 on a 2-way 1GB (64GB HIGHMEM enabled) Netfinity x350 test box 
with the same kernel config and XFS works fine even under stress, so 
perhaps our problem is similar to the discussion on l-k "Google's mm 
problems"...

   Anything I can do to help please ask.

Jim

