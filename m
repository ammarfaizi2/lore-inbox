Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbUKRJwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUKRJwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUKRJwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:52:21 -0500
Received: from outbound.mailhop.org ([63.208.196.171]:52742 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S262701AbUKRJwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:52:10 -0500
Message-ID: <419C70BB.1040002@hanaden.com>
Date: Thu, 18 Nov 2004 03:51:55 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
X-SA-Exim-Connect-IP: 192.168.1.30
X-SA-Exim-Mail-From: hanasaki@hanaden.com
Subject: theory and implemenation of sys/devfs/udev/dev/proc etc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cognition.home.hanaden.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 65.30.41.47
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: hanaden01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone have a pointer to a good technical overview, and details, of how 
specific locations of drivers are determined and used in these special 
directories?

for example, the below udevinfo command shows info from:
	to match the device for which the node will be created.
	looking at the device chain at
		'/sys/devices/pci0000:00/0000:00:07.0':
	====
	udevinfo  -p /sys/class/net/eth0/ -a

and several other locations.  how is the path determined? how are these 
numbers determined?  how do programs use this information to do their 
thing?  are these commonly known address/directories and if so how are 
the paths determined?

this is all darn new to me so please excuse any simple questions to you. 
  I have been reading the kernel source and its slow going.

Thanks,
