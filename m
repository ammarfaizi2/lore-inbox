Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVHKLOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVHKLOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVHKLOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:14:00 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:44986 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S1030268AbVHKLOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:14:00 -0400
Message-ID: <42FB3295.5020200@dresco.co.uk>
Date: Thu, 11 Aug 2005 12:12:21 +0100
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: hdaps-devel@lists.sourceforge.net
Subject: IBM HDAPS - how to freeze i/o?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Heisenberg-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The HDAPS (IBM ThinkPad Hard Disk Active Protection System) project 
currently has working code to read the accelerometer data, and to park 
the hard disk.
However, we're going to need a way to keep the disk idle following the 
park command, as any subsequent command reaching the disk may reactivate 
the drive before it's safe to resume.

Is there any mechanism available in the kernel to 'freeze' the i/o queue?

Thanks,
Jon.


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
