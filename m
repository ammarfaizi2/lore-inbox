Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264809AbUEVBYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbUEVBYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEVBWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:22:16 -0400
Received: from lucidpixels.com ([66.45.37.187]:7572 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263614AbUEVBUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:20:03 -0400
Date: Thu, 20 May 2004 18:07:09 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: How do you enable MCE under Linux 2.6.x?
Message-ID: <Pine.LNX.4.60.0405201805260.29638@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know?

I assume put mce or nomce in append="" line in lilo or grub conf?
   nomce   [IA-32] Machine Check Exception

Also, for 32bit, what is the appropriate device minor/major number for the 
block device /dev/mcelog(if it is applicable to 32bits)?

# /usr/src/linux/Documentation$ grep mce -r *

devices.txt:            227 = /dev/mcelog       X86_64 Machine Check 
Exception driver
kernel-parameters.txt:  mce             [IA-32] Machine Check Exception
kernel-parameters.txt:  nomce           [IA-32] Machine Check Exception
grep: networking/netif-msg.txt: Permission denied
grep: scsi/ChangeLog.megaraid: Permission denied
x86_64/boot-options.txt:   mce=off disable machine check
x86_64/boot-options.txt:   nomce (for compatibility with i386): same as 
mce=off
war@war:/usr/src/linux/Documentation$

