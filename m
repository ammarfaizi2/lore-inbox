Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCLWmc>; Tue, 12 Mar 2002 17:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSCLWmW>; Tue, 12 Mar 2002 17:42:22 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:53904 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S292780AbSCLWmI>; Tue, 12 Mar 2002 17:42:08 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 12 Mar 2002 14:42:03 -0800
Message-Id: <200203122242.OAA08094@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: RE: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet w orking)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please remove changes to 3ware driver (3w-xxxx.[ch]) from your patch.  I
>already 
>submitted a patch that is in 2.5.6-pre3 to do this new dma mapping.

        There are no DMA mapping changes to the 3ware driver in
my patch.  The only change to the 3ware driver in my patch
is to add the PCI device ID table (so that systems can automatically
load the module based on PCI ID).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
