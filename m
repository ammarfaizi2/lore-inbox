Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUFABh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUFABh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUFABh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 21:37:27 -0400
Received: from web90002.mail.scd.yahoo.com ([66.218.94.60]:63384 "HELO
	web90002.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S261474AbUFABhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 21:37:25 -0400
Message-ID: <20040601013724.29760.qmail@web90002.mail.scd.yahoo.com>
Date: Mon, 31 May 2004 18:37:24 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: NFS performance 2.4.21 vs 2.6.7-rc2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cross posting to NFS list as well.

Hello,

I have been doing some testing of NFS performance with
2.4.21 and 2.6.7-rc2 (2.6.5 and 2.6.6 as well).  I
have noticed that 2.4.21 seems to be faster with the
same hardware and mount options as noted by iozone
(iozone -s 1g -r 1m -o).  As well, the amount of CPU
power on the server side is higher for the test run
under 2.6.7-rc2.  Is this known, or have I done
something incorrect?

2.4.21:

1048576    1024   46646   60697   814945   845351 
844893   24716  845657  106998  845220    44423   
60731  811409   841193

2.6.7-rc2:
1048576    1024   42944   48703   536023   546492 
543524   23445  537662   83739  544263   188456  
259651  538667   537420

I have run the same test against NetApp filers and two
different linux file server (2.4.22 and 2.6.7-rc2). 
The client is a 2x 3.0GHz w/8G RAM, Ge (tg3).

Thank you for your time.
Phy





	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
