Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbSLSAOK>; Wed, 18 Dec 2002 19:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbSLSAOK>; Wed, 18 Dec 2002 19:14:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63977
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267413AbSLSAOJ>; Wed, 18 Dec 2002 19:14:09 -0500
Subject: Re: Patch(2.5.52): Add missing PCI ID's for nVidia IDE and PlanB
	frame grabber
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mj@ucw.cz, axboe@suse.de, Andre Hedrick <andre@linux-ide.org>, mlan@cpu.lu,
       toe@unlserve.unl.edu, kraxel@bytesex.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021218153535.A9491@baldur.yggdrasil.com>
References: <20021218153535.A9491@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 01:02:21 +0000
Message-Id: <1040259741.26882.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 23:35, Adam J. Richter wrote:
> Hi Martin,
> 
> 	This patch adds two pci device id definitions needed to make
> a couple of drivers compile in 2.5.52:
> 
> 	drivers/ide/pci/nvidia.c needs PCI_DEVICE_IDE_NVIDIA_NFORCE_IDE
> 	drivers/media/video/planb.c needs PCI_DEVICE_IDE_APPLE_PLANB
> 
> 	If nobody complains, could you please forward these changes to
> Linus and confirm to me that you have done this (so I can have a
> better idea of what to do if they not appear in 2.5.53)?  Thanks in
> advance.

The NVIDIA one is right, someoen removed it from Linus tree by accident
in 2.5.51 or so when adding other Nvidia bits.


