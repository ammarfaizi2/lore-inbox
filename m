Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUETTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUETTHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbUETTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:07:24 -0400
Received: from fate.eng.buffalo.edu ([128.205.25.5]:19161 "EHLO
	fate.eng.buffalo.edu") by vger.kernel.org with ESMTP
	id S264444AbUETTHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:07:23 -0400
Message-ID: <40AD0365.6040003@eng.buffalo.edu>
Date: Thu, 20 May 2004 15:13:41 -0400
From: Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Data loss on IDE drive after crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-Buffalo.EDU-Metrics: fate.eng.buffalo.edu 1029; Body=0 Fuz1=0 Fuz2=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running Fedora Core 2 on an Athlon 2500+ machine with Samsung 
Spinpoint SP0411N 40GB hard drive.  When trying to configure the X 
server for an Nvidia card, the machine froze (this is not the problem).  
Since I did not have access to any other machines on the network at the 
time, I hard rebooted it.

At that point, I had my X configuration file open.  My root partition is 
a small ext2 partition, and on reboot the machine fscked this partition 
and gave me a message like "Deleted i-node for /etc/X11/xOrg.conf 
CLEARED"  (This is from memory).  On reboot, I found that the X config 
file mentioned above had been erased.  Not a trace of it remained..:-)

I don't know if this is a known issue, but I sure would like to hear an 
explanation.  The kernel is the stock kernel provided along with Fedora 
Core 2 (2.6.5-1.358).

Problem is. I can't do more testing for this.  This is a machine I use 
extensively and I don't want the yank the power on it too much.

Thanks,
--Gopi
