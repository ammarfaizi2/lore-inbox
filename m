Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281139AbRKOW6b>; Thu, 15 Nov 2001 17:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281147AbRKOW6W>; Thu, 15 Nov 2001 17:58:22 -0500
Received: from ap.popik.pl ([212.14.18.242]:60308 "EHLO ap.popik.pl")
	by vger.kernel.org with ESMTP id <S281139AbRKOW6G>;
	Thu, 15 Nov 2001 17:58:06 -0500
Date: Thu, 15 Nov 2001 23:56:13 +0100 (CET)
From: Adam Popik <popik@ap.popik.pl>
To: Michael Peddemors <michael@wizard.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with 2.4.14 mounting i2o device as root device Adaptec
 3200 RAID controller?
In-Reply-To: <1005861234.9918.806.camel@mistress>
Message-ID: <Pine.LNX.4.33.0111152351080.7019-100000@ap.popik.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2001, Michael Peddemors wrote:
I have intel i2o controller but I cannot install (install works but cannot 
up my mashine after reboot) with RH7.2 but RH7.1 works fine, also RH7.2 
has stipied fdisk it see 1 (one) cylinder in my array druid see all but 
... installer is stupied with my i2o.... I try use kernel from my  working 
RH  7.1 (2.4.12) with same hardware (i2o intel stl2 mainboard 512MB RAM..) 
and kernel panic.... stupied installer in RH 7.2 ?
Sorry for my english...
Adam

> It may be an esoteric problem in my config, but I installed a RedHat 7.2
> onto an Adaptec (It was strange, I could install one out of 3 tries, but
> rebooting into the 2.4.7-pre that ships with RedHat it got to unloading
> free memory, paused about 2 minutes, the the screen rolls with unable to
> read device messages) 3200s/quantum combination, but it gives me read
> problems on the device, with anything more than 512 MG RAM.  Thought it
> might be kernel related so tried a freshly rolled 2.4.14 kernel, and it
> fails to mount the root point /dev/i2o/hda1 (kernel panic, cannot mount
> 5001)
> Hardware has mostly been ruled out, as we replaced the motherboard/and
> controller as well as the mundane cables and terminators...
> 
> Is anyone successfully using 2.4.14 on an Adaptec 3200s controller?
> This could be a PCI issue, because just we see a lot of interrrupt
> activity on the card just before it dies..
> 
> Am not using modules, compiled the i20 support directly into 2.4.14
> 
> Wanted to get some serious 2.4.14 testing on this platform.. so no
> suggestions about rolling back to 2.2 series.. :)
> 
> 

