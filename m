Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275686AbTHOGfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 02:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275687AbTHOGfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 02:35:12 -0400
Received: from ds217-115-141-147.dedicated.hosteurope.de ([217.115.141.147]:38870
	"EHLO cgscomm1.cgs-online.de") by vger.kernel.org with ESMTP
	id S275686AbTHOGfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 02:35:06 -0400
Subject: Re: 2.4.22-rc2 boot hang
From: Marcel Odendahl <mo@nordsys.de>
Reply-To: mo@nordsys.de
To: linux-kernel@vger.kernel.org
In-Reply-To: <878ypwkz0d.fsf@mcs.anl.gov>
References: <878ypwkz0d.fsf@mcs.anl.gov>
Content-Type: text/plain
Organization: NORDSYS
Message-Id: <1060929303.4378.22.camel@odie.nordsys.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 08:35:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 18:03, Narayan Desai wrote:

Hi,

I have no solution but the same problem. :-(

> We have a netfinity 5100 (including aic7xxx scsi controllers) that
> fails to boot with kernels newer than 2.4.18. The last few lines in
> the boot messages are:
> hda: LTN485S, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-cdrom driver.
> hda: ATAPI 48X CD-ROM drive, 120kB Cache
> Uniform CD-ROM driver Revision: 3.12
> SCSI subsystem driver Revision: 1.00
> 

Here I have two 2 processor maschines which boot without problems up to
kernel 2.4.19. After this kernel version the boot hang after
initializing the scsi subsystem. No error messages or anything else.
The maschines simply hang.

The first maschine has the following configuration:
2 PIII 450mhz
AHA-2940U2/U2W
2 IBM harddisk
Teac SCSI CD-Rom
1 3com 3c905B 

The second maschine has the following configuration:
2 PIII 800mhz
AHA-29160
1 Segate harddisk
1 scsi hp cd-writer
1 ide cd-rom
1 rtl 8139 network card

I've tried to compile a kernel with and without APIC. Tried to compile
the scsi stuff as module and build in. I've read that there can be
problems with network cards, so I also tried to compile the network-card
driver as module and build in. Nothing helped.

With best regards,

Marcel.

