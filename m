Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGMTaq>; Sat, 13 Jul 2002 15:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSGMTap>; Sat, 13 Jul 2002 15:30:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315372AbSGMTap>;
	Sat, 13 Jul 2002 15:30:45 -0400
Message-ID: <3D308080.20306@mandrakesoft.com>
Date: Sat, 13 Jul 2002 15:33:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matt_Domsch@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com>	<3D2FAF94.7070100@mandrakesoft.com>	<1026570939.9958.92.camel@irongate.swansea.linux.org.uk> 	<3D304940.7020207@mandrakesoft.com> <1026579995.13885.8.camel@irongate.swansea.linux.org.uk> <3D307F68.7080703@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Everything you are saying here just convinces me more than we should do 
> this stuff in initramfs.  At the summit Linus endorsed using 
> /sbin/hotplug when storage devices appear... combine that with 
> initramfs, and you should have all you need to handle whatever complex 
> scenario you come up with.  It sounds straightforward to have some 
> find-the-root-device code in initramfs that can contain "if 
> (dell_mainboard)" code all over the place.



IOW, strive to make order of kernel device initialization irrelevant -- 
init the kernel drivers, then figure out the boot device.

	Jeff


