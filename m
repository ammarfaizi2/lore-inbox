Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319637AbSIMNDM>; Fri, 13 Sep 2002 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319638AbSIMNDM>; Fri, 13 Sep 2002 09:03:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:24827
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319637AbSIMNDL>; Fri, 13 Sep 2002 09:03:11 -0400
Subject: Re: Possible bug and question about ide_notify_reboot in
	drivers/ide/ide.c (2.4.19)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
References: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 13 Sep 2002 14:09:13 +0100
Message-Id: <1031922553.9056.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second, why do we need to put the disks on standby before halting? I ask because putting
> the disks on standby puts my hard drives into a coma!! When I power up after a halt, 

To make sure they have written back their caches, put themselves into
happy safe sleeping mode and are quiet.

> I have
> to go into the BIOS and force auto-detect to wake them back up. I've removed the "standby"
> code and things seem to be functioning normally. I have an Epox 8K7A motherboard with two
> Maxtor Hard drives (model 5T040H4).
> 

Congratulations your BIOS sucks 8)

