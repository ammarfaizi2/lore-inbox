Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTEZNty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTEZNty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:49:54 -0400
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:17057 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S264369AbTEZNtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:49:51 -0400
Message-ID: <016e01c3238f$846e4320$928afea9@hal>
From: "Gutko" <gutko@poczta.onet.pl>
To: <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305251900170.1211-100000@coffee.psychology.mcmaster.ca> <00f001c32381$7eaf5900$928afea9@hal> <3ED21294.30701@hifo.unizh.ch>
Subject: Re: Still no DMA on boot on S-ATA (Asus A7N8X-deluxe)
Date: Mon, 26 May 2003 16:03:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>I can enable udma5 using hdparm, later in rc.local but why it is not
> >
> how do you do this?
hdparm -d1 -X udma5 -c1 -m16 /dev/hde

> what kind of Problems?
data corruption

http://www.nforcershq.com/forum/viewtopic.php?t=5108&highlight=data+corruption


>
> I've noticed that with the 2.4.21-rc2 it wasn't possible to use
> framebuffer AND the SiI3112 at the same time. I had to disable fb
> because of this (no loss for me, the debian installer works without fb
> too .-))

I dont know how it was in pure rc2. I always patched it with Alan's  -ACx
> Is this solved in -rc3?

if you have more than 512MB try passing "mem=512" to lilo. seems to work


