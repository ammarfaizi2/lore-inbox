Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284688AbRLUQSP>; Fri, 21 Dec 2001 11:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284726AbRLUQR4>; Fri, 21 Dec 2001 11:17:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284710AbRLUQRu>; Fri, 21 Dec 2001 11:17:50 -0500
Subject: Re: conclusion: arp.c *must* be (still) defective
To: mail_ker@xarch.tu-graz.ac.at (Alex)
Date: Fri, 21 Dec 2001 16:27:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112211437400.793-100000@xarch.tu-graz.ac.at> from "Alex" at Dec 21, 2001 02:43:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HSWd-0000eY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whenever I ping my nexthop router (ip: x.x.x.1) i get a pause of a few
> seconds, then a whole sequence of "Destination unreachable".
> Looking at the arp cache using "arp -a", I see that the arp cache is
> always incomplete (always KEEPS being incomplete). 

Sounds like you have the card on the wrong port or the IRQ not set in the
BIOS to be routed to ISA
