Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265017AbTFCN6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265018AbTFCN6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:58:31 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:4317 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S265017AbTFCN6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:58:30 -0400
Date: Tue, 3 Jun 2003 10:11:59 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: linux-kernel@vger.kernel.org
Subject: Re: siimage driver status
In-Reply-To: <3EDC4B72.7090407@hifo.unizh.ch>
Message-ID: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two drives (WD Raptors) on my A7N8X. I don't see any errors, even 
after writing 9GB of data to the drive (after I've done an hdparm -X66 
-d1 /dev/hd[x]), but it still boots up in pio mode. 
Is there some silly hack I can do to the driver code to force all devices 
to DMA on bootup? Everything works fine except for that. I'm using 
2.4.21-rc6-ac1
Thanks!
	-Josiah


This issue was reported by at least 3 People here on the list (including 
me) with different 21-rcX kernels. Seems noone really cared :-(

I hope, this issue now get's addressed.
btw. I could speed up my Transfer-Rate from 1.7MB/s to 55MB/s by setting
hdparm -d1 -X66 on my two native SATA-Drives.

bye

Marco

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

