Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbULPRFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbULPRFD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULPRFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:05:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7398 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261948AbULPREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:04:32 -0500
Subject: Re: 3TB disk hassles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Michelle Konzack <linux4michelle@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
	 <200412161537.02804.m.watts@eris.qinetiq.com>
	 <20041216155216.GA3854@freenet.de>
	 <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103212832.21920.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 16:00:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 16:03, Jan Engelhardt wrote:
> >You can have 4 TByte on one 12-Channel Card,
> >but in two Arrays of 6 HDD's   :-)
> 
> Maybe some LVM trickery can aggregate ungrowable hardware raids together to a 
> single block device.

LVM does not mix with volumes > 2Tb in my experience. I don't know if
anyone has fixed it yet but I'd advise caution.

Remember you don't need a partition table. You can just leave the volume
unpartitioned. You can also use other partition formats providing you
don't need the BIOS boot gunk to boot off that volume. 

Alan

