Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTIJNPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTIJNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:15:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45706 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262796AbTIJNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:15:02 -0400
Subject: Re: [2.4] siimage locks hard on high load
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Witold Krecicki <adasi@kernel.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309121344.43573.adasi@kernel.pl>
References: <200309121344.43573.adasi@kernel.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063199623.32726.55.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 14:13:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 12:44, Witold Krecicki wrote:
> I've got Asus a7n8x deluxe with on-board Silicon Image SATA and 2xBarracuda 
> 120GB connected to it in software RAID array.
> On high disk load (e.g. cp -Rf /usr/src/linux somewhere_else) kernel locks 
> hard after about 10 seconds (magic sysrq is not working).
> It happens only when DMA is enabled. 

Make sure you have at least 2.4.22, and if your system is Nvidia chipset
see the notes on www.siimage.com, you may need a bios update

