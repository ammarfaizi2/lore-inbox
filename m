Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRCIPDF>; Fri, 9 Mar 2001 10:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130528AbRCIPCy>; Fri, 9 Mar 2001 10:02:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130521AbRCIPCs>; Fri, 9 Mar 2001 10:02:48 -0500
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patc
To: linux-usb-devel@lists.sourceforge.net
Date: Fri, 9 Mar 2001 15:04:17 +0000 (GMT)
Cc: david-b@pacbell.net (David Brownell),
        manfred@colorfullife.com (Manfred Spraul), zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <879158D1D558D4118DBD0008C7CF32A9015834A7@tayexc07.tay.cpqcorp.net> from "Hicks, Jamey" at Mar 09, 2001 09:27:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bORJ-00055Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> USB controller driver?  If not, then let's just set up an uncached mapping
> of all of DRAM and use a modified version of virt_to_bus and bus_to_virt.

If your CPU supports uncached mappings..

