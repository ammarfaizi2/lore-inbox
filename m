Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSLLSVE>; Thu, 12 Dec 2002 13:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSLLSVD>; Thu, 12 Dec 2002 13:21:03 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:32966
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264975AbSLLSVA>; Thu, 12 Dec 2002 13:21:00 -0500
Subject: Re: [PATCH] nforce2 dma enabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Krieglstein <tstone@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212140612.GA543@Timekeeper>
References: <20021212140612.GA543@Timekeeper>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 19:06:37 +0000
Message-Id: <1039719998.22202.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 14:06, Tim Krieglstein wrote:
> The patch just adds the pci id of the nforce ide controller and added a
> new information block to the ide_pci_device_t structure. Also i added an
> entry to pci_device_id.

Thanks. 

> welcome. I would also like to know why the lspci command still tells me
> this is an unknown device after applying my patch seen below. Also if

lspci uses its own tables in user space

> someone has a hint why the usb-devices have no interrupt assigned and
> thus are not available is very welcome (probably disable acpi?).

The BIOS didnt assign one. Since we don't have any useful docs we also
can't reassign one unless the BIOS does it - which it might do.


