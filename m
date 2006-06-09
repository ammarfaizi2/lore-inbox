Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWFIO6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWFIO6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWFIO6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:58:50 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:34299 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030195AbWFIO6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:58:49 -0400
Date: Fri, 9 Jun 2006 09:57:57 -0500
From: Hui Zhou <hzhou@hzsolution.net>
To: linux-kernel@vger.kernel.org
Subject: Frustrating Random Reboots, seeking suggestions
Message-ID: <20060609145757.GB1640@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lists,

I understand this type of ask for help may be slightly off topic here, 
but hoping for some clue to my desperation, here it goes:

I am running a linux machine with a self programmed pvr running on it. 
All is well until I reinstalled the linux system a few weeks ago. Now 
I am suffering from random reboots. The reboots does not leave any 
debug messages or clues. After some isolation, I finally narrowed it 
down to a blankscene marking program -- bkmark. Running bkmark against 
any recording randomly reboots the computer. By random, I mean  it may 
complete sucessfully once, but repeating it for a few times, the 
reboots will happen.  On average, it reboots every 2 - 3 runs.

I am happy with and used to seg faults, which given time, I can 
debug it. But this random reboots stuff is new to me and I have no 
clues at all. How and why would a user land program reboots the 
system?

I am running debian stable. Self compiled unpatched kernel 2.6.16.15 
PREEMPT. Single Pentium 2.8GHz on Intel 865P motherboard. bkmark uses 
libmpeg2 shared library. The source code is 471 lines, availible on 
request. The same program runs without problem on the system before 
(debian unstable) and even before (debian stable, but that was 5 months 
ago) and even with the same kernel (2.6.14.6, I updated the kernel 
after this problem occured).

More info is availible but I felt it may be inapprorate to post here 
and honestly I have no clue which info is relavant. Any suggestions 
or clues or advices on how to debug or narrow down the cause are very 
appreciated.

Thank you.

-- 
Hui Zhou
