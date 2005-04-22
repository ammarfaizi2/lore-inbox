Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVDVPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVDVPMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVDVPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:11:18 -0400
Received: from eagle.melbpc.org.au ([203.12.152.41]:57238 "EHLO
	vscan41.melbpc.org.au") by vger.kernel.org with ESMTP
	id S261970AbVDVPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:03:23 -0400
Message-ID: <4269122F.6050208@melbpc.org.au>
Date: Sat, 23 Apr 2005 01:03:11 +1000
From: Charles Mydlak <cmydlak@melbpc.org.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel lockup when swapping out to swap partition in 250G extended
 partition
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Filtered-With: renattach 1.2.2
X-RenAttach-Info: mode=badlist action=rename count=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running the 2.6.11.7 kernel (and others) and all of them have a 
problem with locking up when they try to swap out memory, to a swap 
partition, that is located in an extended partition which is 200G
in size. The same problem does not occur when the swap partition is
a primary partition on the same drive.
Another problem that is probably related, was when I first formatted
the drive using fdisk, and then did a reboot I got a kernel divide by
zero message with cpu register dumps. I can't seem to replicate this
error though.

The software is Fedora Core 2 and the KDE desktop.

Sorry if this is a bit vague, but I'm not sure what type of
information you require to locate the bug.

Regards
Charles Mydlak
