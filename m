Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSGZGTI>; Fri, 26 Jul 2002 02:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGZGTI>; Fri, 26 Jul 2002 02:19:08 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:30662 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S317007AbSGZGTI>; Fri, 26 Jul 2002 02:19:08 -0400
Subject: Re: Intel Plumas Chipset and 100Mhz PCI cards
From: Christopher Leech <christopher.leech@intel.com>
To: aby_sinha@yahoo.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1562@orsmsx118.jf.intel.com>
References: <BD9B60A108C4D511AAA10002A50708F22C1562@orsmsx118.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Jul 2002 23:10:10 -0700
Message-Id: <1027663813.13982.17.camel@orthanc>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only is the bus running at 66 MHz, it's using the PCI protocol not
PCI-X.  Is there a card in the other PCI-X capable slot?  I think they
are on the same bus, so installing a PCI card there would bring both
slots down to this speed.  You should check the output of lspci -v and
make sure all the devices on bus 2 have the PCI-X capability.

- Chris Leech

> PCI_Bus_Type                     PCI
> PCI_Bus_Speed                    66MHz
> PCI_Bus_Width                    64-bit


