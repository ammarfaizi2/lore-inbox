Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRCJT0g>; Sat, 10 Mar 2001 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbRCJT00>; Sat, 10 Mar 2001 14:26:26 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:12501 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S131139AbRCJT0G>;
	Sat, 10 Mar 2001 14:26:06 -0500
Message-ID: <3AAA7FA2.2000803@lycosmail.com>
Date: Sat, 10 Mar 2001 14:25:22 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac17 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VMware 2.0.3 & Kernel 2.4.2-ac17
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling the vmnet module, there is a warning

make: Entering directory `/tmp/vmware-config2/vmnet-only'
bridge.c: In function `VNetBridgeReceiveFromDev':
bridge.c:788: warning: implicit declaration of function `skb_datarefp'

and while inserting the module

/tmp/vmware-config2/vmnet.o: unresolved symbol skb_datarefp

I have traced this back to 2.4.2-ac4 by looking for where this function 
was removed.

yes, technically this probably is OT, and properly belong on the VMware 
list, but I can't access their nntp server.

basically, why was this function removed, what did it do, what can be 
done to make VMware run again?

