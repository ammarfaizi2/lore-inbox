Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWIDMMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWIDMMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWIDMMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:12:53 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:7861 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751304AbWIDMMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:12:51 -0400
Date: Mon, 4 Sep 2006 14:07:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Grant Coady <gcoady.lk@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
In-Reply-To: <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
Message-ID: <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I just pulled the "pata-drivers" branch of libata-dev.git into the 
>>"upstream" branch, which means that Alan's libata PATA driver collection 
>>is now queued for 2.6.19.
>>
>>Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for 
>>many months.  Community-wise, no one posted objections to the PATA 
>>driver merge plan, when Alan posted it on LKML and linux-ide.
>
>Too friggin' hard to test Alan's stuff for older IDE here, therefore 
>ignored so far :(   I have some old hardware that Alan is addressing, 
>even an old IBM 260MB PCMCIA HDD.
>
>I can't see an easy way to arrange multi-boot with different /etc/fstab 
>depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?

Got udev?

/dev/disk/by-id/ata-ST3802110A_5LR13RN7-partX could be your friend.

>Plus, 2.6.18-rcX fails too early in boot on one machine (p100 IBM 365X) 
>for any testing.  Suggestions welcome...

dmesg or any log.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
