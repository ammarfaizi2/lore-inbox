Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSLSUMP>; Thu, 19 Dec 2002 15:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLSUMP>; Thu, 19 Dec 2002 15:12:15 -0500
Received: from cable-212.76.255.184.coditel.net ([212.76.255.184]:4100 "EHLO
	piglet.grunz.lu") by vger.kernel.org with ESMTP id <S266101AbSLSUMN>;
	Thu, 19 Dec 2002 15:12:13 -0500
Date: Thu, 19 Dec 2002 21:17:03 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Patch(2.5.52): Add missing PCI ID's for nVidia IDE and PlanB frame grabber
To: alan@lxorguk.ukuu.org.uk
cc: adam@yggdrasil.com, mj@ucw.cz, axboe@suse.de, andre@linux-ide.org,
       toe@unlserve.unl.edu, kraxel@bytesex.org, linux-kernel@vger.kernel.org
In-Reply-To: <1040259741.26882.0.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18P76a-00007a-00@piglet.grunz.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  19 Dec, this message from Alan Cox echoed through cyberspace:
> On Wed, 2002-12-18 at 23:35, Adam J. Richter wrote:
>> Hi Martin,
>> 
>> 	This patch adds two pci device id definitions needed to make
>> a couple of drivers compile in 2.5.52:
>> 
>> 	drivers/ide/pci/nvidia.c needs PCI_DEVICE_IDE_NVIDIA_NFORCE_IDE
>> 	drivers/media/video/planb.c needs PCI_DEVICE_IDE_APPLE_PLANB
>> 
>> 	If nobody complains, could you please forward these changes to
>> Linus and confirm to me that you have done this (so I can have a
>> better idea of what to do if they not appear in 2.5.53)?  Thanks in
>> advance.
> 
> The NVIDIA one is right, someoen removed it from Linus tree by accident
> in 2.5.51 or so when adding other Nvidia bits.

The PLANB one is right as well; it probably never was in there, but is
indeed useful to the driver.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

