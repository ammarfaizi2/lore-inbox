Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSF3NYJ>; Sun, 30 Jun 2002 09:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSF3NYI>; Sun, 30 Jun 2002 09:24:08 -0400
Received: from [62.70.58.70] ([62.70.58.70]:54405 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315167AbSF3NYH> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 09:24:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Juri Haberland <juri@koschikode.com>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
Date: Sun, 30 Jun 2002 15:26:36 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301504.35221.roy@karlsbakk.net> <3D1F0373.9070104@koschikode.com>
In-Reply-To: <3D1F0373.9070104@koschikode.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301526.36144.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume the onboard IDE stuff (hdm) is something like a Promise
> controller. If so you should be able set the boot order to boot from the
> normal IDE chipset (hda/hdb). If doesn't help I'd suggest that you ask
> on the linux-raid mailing list.

The on-board is a VIA controller. see from lspci

00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
02)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
02)
00:0e.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

and - as for linux-raid, see below:

   ----- The following addresses had permanent fatal errors -----
<linux-raid@vger.rutgers.edu>
    (reason: 550 5.1.1 <linux-raid@vger.rutgers.edu>... User unknown)



-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

