Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284575AbRLRSln>; Tue, 18 Dec 2001 13:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284521AbRLRSkb>; Tue, 18 Dec 2001 13:40:31 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20718 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284537AbRLRSjW>; Tue, 18 Dec 2001 13:39:22 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181544.fBIFirL16397@pinkpanther.swansea.linux.org.uk>
Subject: Re: PDC20265 IDE controller trouble
To: jurij.smakov@telia.com (Jurij Smakov)
Date: Tue, 18 Dec 2001 15:44:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hahn@physics.mcmaster.ca
In-Reply-To: <Pine.GHP.4.43.0112161058510.11934-100000@bobcat> from "Jurij Smakov" at Dec 16, 2001 12:44:36 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are the bonnie results on a RAID0 in my setup (kernel 2.4.17-pre8,
> raidtools 0.9.0, PDC20265 controller on Asus TUSL2 motherboard, 2 IBM
> 60GB disks, one disk per channel). /etc/raidtab contains:

Check you have the right IDE driver compiled in. Also try the RH 2.4.9
or a 2.4.12-ac8 type kernel and see if its about 10 times faster. For some
stuff it seems 2.4.10 destroyed performance and Andrea has yet to fix that
although lots of other stuff has recovered from the VM mess

