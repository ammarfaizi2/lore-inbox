Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284298AbRLBTkx>; Sun, 2 Dec 2001 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284295AbRLBTkl>; Sun, 2 Dec 2001 14:40:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284286AbRLBTkd>; Sun, 2 Dec 2001 14:40:33 -0500
Subject: Re: IBM Thinkpad T21: Hotplugging of cdrom and floppy devices
To: klink@clouddancer.com
Date: Sun, 2 Dec 2001 19:49:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011202193450.B36E77843A@phoenix.clouddancer.com> from "Colonel" at Dec 02, 2001 11:34:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Acc7-0004Ku-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect there is a BIOS function that handles the device change,
> since that is where the suspend actually occurs.  Windows must call it
> directly.  Hotplugging is for the standard interfaces, the thinkpad
> Ultrabay is unique.  You should probably be asking the IBM linux
> group.

My first guess would be that you want to look at the PNPBIOS support from
the -ac tree and see if you get PNPBIOS events.
