Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUEQPIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUEQPIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUEQPGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:06:53 -0400
Received: from bay18-f106.bay18.hotmail.com ([65.54.187.156]:46861 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261602AbUEQPGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:06:16 -0400
X-Originating-IP: [141.156.159.253]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: baldrick@free.fr, gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Mon, 17 May 2004 15:06:15 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F106WMUe77sHG0002bb5f@hotmail.com>
X-OriginalArrivalTime: 17 May 2004 15:06:16.0011 (UTC) FILETIME=[802A91B0:01C43C20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to all, it turns out (in two separate cases I had two different 
problems that affected the results).

Case 1: No SMP turned on for CPU w/HT after fix (~4.78 seconds compile time 
(2.6GHZ w/HT))
Case 2: Box had 4GB of NON-ECC memory in it, only recognized 2.56GB, took 
out (2) 1GB DDR DIMM's, and the speed returned what it should be. (~4.3 
seconds compile time (3.0GHZ w/HT))

The control box was a 2.53GHZ (533MHZ BUS w/NO HT) = ~5.3seconds

I have not tested 2.6.6 recently, but in one of my tests I believe it worked 
OK, ever since 2.6.6 removed my /etc/lilo.conf and /etc/mtab and several 
other files, I do not wish to touch that kernel with a 10 foot poll :-P due 
to the IDE disk flush/cache issue.

>From: Duncan Sands <baldrick@free.fr>
>To: gene.heskett@verizon.net, "Justin Piszcz" <jpiszcz@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
>Date: Mon, 17 May 2004 10:07:17 +0200
>
> > I noted that my epson C82 usb printer was running about 25% of its
> > normal speed last night, it took gimp-print several hours to do half
> > a dozen 8x10's in 720dpi.  gkrellm's display looks normal though,
> > with setiathome currently taking 90+% of the cpu, which is normal.
>
>2.6.6 or 2.6.6 plus patches from BK or -mm?
>
>Thanks,
>
>Duncan.

_________________________________________________________________
Best Restaurant Giveaway Ever! Vote for your favorites for a chance to win 
$1 million! http://local.msn.com/special/giveaway.asp

