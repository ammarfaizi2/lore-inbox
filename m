Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGAVEy>; Mon, 1 Jul 2002 17:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSGAVEx>; Mon, 1 Jul 2002 17:04:53 -0400
Received: from batleth.sapienti-sat.org ([213.61.61.242]:2700 "EHLO
	batleth.sapienti-sat.org") by vger.kernel.org with ESMTP
	id <S316519AbSGAVEw>; Mon, 1 Jul 2002 17:04:52 -0400
Message-ID: <3D20C481.2020208@koschikode.com>
Date: Mon, 01 Jul 2002 23:07:13 +0200
From: Juri Haberland <juri@koschikode.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
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

What buffles me is that - according to your dmesg output at
http://karlsbakk.net/bugs/dmesg - the disk connected to the onboard VIA
controller are detected as hdm-hdp.
Have you checked you BIOS settings? Some mainboards allow to use
off-board controllers to be used before the on-board ones...

Juri

