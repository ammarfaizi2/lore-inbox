Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRIJUsX>; Mon, 10 Sep 2001 16:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271687AbRIJUsP>; Mon, 10 Sep 2001 16:48:15 -0400
Received: from adsl-216-63-236-137.dsl.tulsok.swbell.net ([216.63.236.137]:32750
	"EHLO gateway1.brets.elevating.com") by vger.kernel.org with ESMTP
	id <S271677AbRIJUsI>; Mon, 10 Sep 2001 16:48:08 -0400
Message-ID: <3B9D271D.FA84C32C@elevating.com>
Date: Mon, 10 Sep 2001 15:48:29 -0500
From: Bret Hughes <bhughes@elevating.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, ja
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: directory cache problems (I think)]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this to the linux XFS list but nothing useful in the way of
responses.  


I have a configuration on 6 boxes, Duron 700 with 128 MB ram and 10GB
ide harddrives.  These machines are all XFS 1.0.1 using the kernel from
the 1.0.1 RH install iso and most of the RH updates.


They were all placed into service the same day and yesterday 5 days
after they were turned on they all stopped responding to ssh.  A couple
would still respond to a ping but nothing else.   Actually I caught one
before it quit altogether and rebooted it last night. These machines are
kiosk type displays that scroll html and flash pages using (netscape as
the browser).  There is no user interaction infact not any input device
at all.  A different page is displayed every 10 seconds.

Now, After rebooting them I can get to the sadc data and looking through
the logs shows really bad stuff happening at 1:00PM yesterday on the one
machine I have really looked at closely.  interrupt 14s out the wazoo
and what I think must be the cause, the dentunusd goes to 0.  Looking
over the logs of the last few days I can see the dentunusd creeping down
from the beginning at boot of over 20K to 0.  

Is this the problem or a symptom of something else?

Since netscape is such a pig I kill it and restart it once an hour and
restart X once a day.  both these events seem to take a tremendous toll
on the dentunusd value and never gain it all back.  

I don't know if this is an XFS issue or not but I as I said I started at 
the XFS list and no joy yet so I thought that I would try here.  Any 
ideas?  

I can send all the log data anyone might use if it would help.  
Right now I am going to reboot the damn things nightly like they were 
windows machines for Christ's sake.

BTW the same scenario and control scripts run for months on end on RH
6.2 using the 2.2.3-16 kernel.

Any tips and or other places to ask are appreciated. 

TIA

Bret
