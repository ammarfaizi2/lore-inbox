Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUAGXtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbUAGXtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:49:21 -0500
Received: from smtp-out7.blueyonder.co.uk ([195.188.213.10]:17452 "EHLO
	smtp-out7.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265508AbUAGXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:48:17 -0500
From: James Cort <jim@whitepost.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Stability problem on a Gigabyte motherboard
Date: Wed, 7 Jan 2004 23:52:38 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401072352.38578.jim@whitepost.org.uk>
X-OriginalArrivalTime: 07 Jan 2004 23:48:32.0980 (UTC) FILETIME=[C2575140:01C3D578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using Linux for ages now, and I think the time has finally come to 
ask a question in this forum.

Doubtless I'm totally wrong and will be flamed into oblivion, but hey...

I have a Gigabyte GA-7VAXP motherboard, and I'm using kernel 2.4.23. This 
board is based on a VIA-KT400 chipset, with UDMA-133 and USB 2 support.

Versions of the BIOS prior to F11 are stable but USB 2 support is broken.

Later BIOS versions have fixed USB 2 support, but render my system unstable - 
va-ctcs dies in under 10 seconds, locking the entire machine such that there 
are no logs, no visible kernel panic to console and the magic sys-rq key 
doesn't work. Similar symptoms can be observed doing heavy disk writes to a 
USB 2 external hard disk or decompressing a large archive (such as the kernel 
source) to the internal IDE disk.

I've searched the mailing list archives, asked Gigabyte, Googled, asked my 
local LUG and looked at the VIA web forums, all to no avail. So now I ask the 
good people here - are there any known issues with VIA chipset support which 
might cause this?

TBH, the lack of logs I'm getting means I'm not sure if the problem is because 
of lousy BIOS writing on the part of Gigabyte or a genuine bug in the kernel. 
However, any helpful suggestions will be most gratefully received.

James Cort

-- 
Conserve wildlife - pickle a squirrel

