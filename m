Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSF3N7q>; Sun, 30 Jun 2002 09:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSF3N7p>; Sun, 30 Jun 2002 09:59:45 -0400
Received: from [62.70.58.70] ([62.70.58.70]:56197 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315191AbSF3N7n> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 09:59:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Juri Haberland <juri@koschikode.com>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Sun, 30 Jun 2002 16:02:10 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301526.36144.roy@karlsbakk.net> <3D1F0910.9020107@koschikode.com>
In-Reply-To: <3D1F0910.9020107@koschikode.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301602.10599.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The on-board is a VIA controller. see from lspci
> >
> > 00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20268
> > (rev 02)
> > 00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20268
> > (rev 02)
> > 00:0e.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
> > 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
>
> So you have your two raid drives connected to the VIA controller, right?
> Then have a look into the BIOS setup and see, if there's something that
> might affect the boot order...

I have 4 drives connected to each controller, that is, 2 drives per channel. 
None are RAID controllers - just stupid ATA controllers. 

point isn't to change bootorder - just to make bloody LILO work.

See fstab, jumbo-dmesg.txt, mdstat and raidtab in http://karlsbakk.net/bugs/ 
for more info

thanks

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

