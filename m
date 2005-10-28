Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVJ1QhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVJ1QhD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVJ1QhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:37:03 -0400
Received: from imo-m17.mx.aol.com ([64.12.138.207]:12007 "EHLO
	imo-m17.mx.aol.com") by vger.kernel.org with ESMTP id S1030242AbVJ1QhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:37:01 -0400
From: AndyLiebman@aol.com
Message-ID: <13f.1f173bf2.3093ada5@aol.com>
Date: Fri, 28 Oct 2005 12:36:53 EDT
Subject: Premptible Kernels and Timer Frequencies
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all responsible for getting the 2.6.14  kernel out quickly. There 
are many important bugfixes and features in this  kernel that are relevant to 
my work. I look forward to using it starting today!  

I have a request. Would it be possible for a knowledgeable person to  write 
up a little description of some of the following kernel options and what  they 
REALLY mean and how to use them? I think it would be great to put a brief  
"white paper" on the kernel.org site. 

In specific, I am referring to the  following: 

Premptible Kernel Model
No  Premption
Voluntary Premption
Premptible Kernel (Low-latency Desktop)

Prempt The Big Kernel  Lock

Timer Frequency
100 Hz
250 Hz
1000 Hz


I think it would be helpful for  the whole Linux community to get better 
hints about the theoretical optimal  settings for various types of systems. Saying 
that one option is good for  "desktops" and another is good for "servers" is 
a start, but I'm sure that with  just a few more words, you could be much more 
helpful to users who are trying to  decide what options to select for 
compiling. 

For instance, I have a  number of file servers that send video files out 
simultaneously to multiple  video editing systems. Each of 10-20 video editing 
systems could be reading  files from the server (or writing files to the server) 
at data rates ranging  from 3.5 MB/sec up to 30,40 or 50 MB/sec. 

The server ITSELF is rarely  running any applications other than Samba, 
Netatalk, Software RAID 0, NIC  drivers, and fairly low-CPU usage things like the 
UPS monitor, 3ware Drivers for  Hardware RAID 5, and KDE (which is hardly ever 
getting any input from users).  

We get really great performance with the 2.6.12 and 2.6.10 kernels. And  
typically, CPU usage ranges from 10-20 perecent with many client systems going.  
However, we are wondering if it is worth it to try the Preemptible Kernels for  
greater responsiveness and perhaps support for more simultaneous streams, 
which  MUST arrive at the video editing system on time or we get "dropped 
frames".  

I'm sure it's a similar situtation to Video On Demand servers only our  data 
rates are much higher per client, so we can't support that many clients as  a 
VOD system. 

We have tested compiling the 2.6.12 kernel with both  voluntary preemption 
and low-latency preemption. Both seem to work fine, but we  haven't 
stress-tested them yet because we were waiting for the 2.6.14 kernel to  come out. 

Could we get into any danger with the preemptible kernels if  the system load 
gets heavy? 

And now that the Timer frequency option has  been added, what would be 
optimal for such a video server that is not itself  running any taxing applications? 

Hope to hear from one of the "big guys"  on this. 

Thanks again for all your great work. 

Andy Liebman  

