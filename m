Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbSKFE0f>; Tue, 5 Nov 2002 23:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSKFE0f>; Tue, 5 Nov 2002 23:26:35 -0500
Received: from seqserv.seqnet.net ([207.174.23.5]:16142 "EHLO seqnet.net")
	by vger.kernel.org with ESMTP id <S265647AbSKFE0a>;
	Tue, 5 Nov 2002 23:26:30 -0500
Message-ID: <3DC89B7D.6000802@ucar.edu>
Date: Tue, 05 Nov 2002 21:33:01 -0700
From: vanandel@ucar.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: karim@opersys.com, LTT-Dev <ltt-dev@shafik.org>
Subject: please include LTT in the Linux kernel
References: <3DC727CD.96EE29AE@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Apparently Linus doesn't see what this patch buys Linux. Since
> I can't personally convince him otherwise, having written LTT
> myself, here it is in the hope that others on the list actually
> find it of some use.

I am quite interested in having LTT as a configurable option in the 
Linux kernel.  My company (the National Center for Atmospheric Research) 
uses networks of Linux computers to process data from weather radars. 
Occasionally, we've had unexplained performance problems where the 
system is slow to respond, even though the process load is low on each 
computer and no process is "hogging" the CPU.  LTT would be extremely 
valuable to help us diagnose such problems, since we could see the 
interaction of our processing and radar display tasks with the kernel 
and the NFS daemons.

Also, we build Linux based data acquisition systems containing signal 
processing cards.  LTT would really help us tune the performance of 
these systems, since we could see how quickly our processes are 
scheduled in response to interrupts from the signal processing cards.

Please, include LTT in the Linux kernel.  Karim and others have 
demonstrated that LTT has no impact on kernel performance if it is not 
configured, and minimal impact even when tracing is enabled.  I've used 
a commercial product (Stethoscope - sold by Real Time Innovations) when 
doing real-time programming on VxWorks, and found it quite valuable.  If 
LTT is included in the Linux kernel, Linux will be much more appealing 
to the real-time and embedded programming community.



