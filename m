Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSF3NdE>; Sun, 30 Jun 2002 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSF3NdD>; Sun, 30 Jun 2002 09:33:03 -0400
Received: from sto-vo-kor.koschikode.com ([213.61.61.142]:15635 "EHLO
	sto-vo-kor.koschikode.com") by vger.kernel.org with ESMTP
	id <S315168AbSF3NdD>; Sun, 30 Jun 2002 09:33:03 -0400
Message-ID: <3D1F0910.9020107@koschikode.com>
Date: Sun, 30 Jun 2002 15:35:12 +0200
From: Juri Haberland <juri@koschikode.com>
Organization: totally unorganized
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
References: <20020630124445.6E95B11979@a.mx.spoiled.org> <200206301504.35221.roy@karlsbakk.net> <3D1F0373.9070104@koschikode.com> <200206301526.36144.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
>> I assume the onboard IDE stuff (hdm) is something like a Promise
>> controller. If so you should be able set the boot order to boot from the
>> normal IDE chipset (hda/hdb). If doesn't help I'd suggest that you ask
>> on the linux-raid mailing list.
> 
> The on-board is a VIA controller. see from lspci
> 
> 00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
> 02)
> 00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 
> 02)
> 00:0e.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

So you have your two raid drives connected to the VIA controller, right?
Then have a look into the BIOS setup and see, if there's something that
might affect the boot order...

> and - as for linux-raid, see below:
> 
>    ----- The following addresses had permanent fatal errors -----
> <linux-raid@vger.rutgers.edu>
>     (reason: 550 5.1.1 <linux-raid@vger.rutgers.edu>... User unknown)

No wonder, vger.rutgers.edu ceased to exist ~2 years ago. Use
vger.kernel.org instead ;)

Juri

