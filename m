Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSIBHt3>; Mon, 2 Sep 2002 03:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSIBHt3>; Mon, 2 Sep 2002 03:49:29 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:13802 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318027AbSIBHt3>; Mon, 2 Sep 2002 03:49:29 -0400
Date: Mon, 2 Sep 2002 09:53:34 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Promise PDC20276 & 2.2.19
Message-ID: <20020902075334.GA6376@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Bartlomiej Zolnierkiewicz wrote:

> Stupid me :-)
> Setting it on/off won't help :-)

Stupid^2, please set it on and change this #ifdef.

> Just change '#ifdef' around
>       if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID)
> in ide-pci.c to '#ifndef' and it should work.

Works fine here, as it did up to 2.4.19rc1.

Otherwise, may be you must install the driver
(closed source) from Promise. I never tested this.

-- 
Regards Klaus
