Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbTAIQyg>; Thu, 9 Jan 2003 11:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTAIQyf>; Thu, 9 Jan 2003 11:54:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55437
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266842AbTAIQyf>; Thu, 9 Jan 2003 11:54:35 -0500
Subject: Re: small fix for nforce ide chipset driver in 2.5.54
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Curbo <phoenix@sandwich.net>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109065642.GA6251@carthage>
References: <20030108075539.GA4128@carthage>
	 <1042034033.24099.2.camel@irongate.swansea.linux.org.uk>
	 <20030109065642.GA6251@carthage>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042134541.27796.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 17:49:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 06:56, James Curbo wrote:
> Well, I thought this deal was over but apparently not. My 2.5.54 kernel
> is still working fine, but when I compiled 2.4.20-ac2, it didn't pick up
> my Nforce2 IDE. On a whim I checked include/linux/pci_ids.h and it has a
> different PCI ID for PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, namely 0x01bc.
> (lspci -v reports 0x0065 here). Perhaps 0x01bc is the nforce1 ide
> chipset and 0x0065 is the nforce2 ide chipset?

2.4.21pre3-ac2 should support the Nforce and Nforce2. Its not the final driver
for 2.4 or 2.5 (there is a much nicer merged AMD/Nvidia one) but it will wait
until after 2.4.21 before I merge it.


