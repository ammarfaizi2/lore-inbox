Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130588AbRCISek>; Fri, 9 Mar 2001 13:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCISea>; Fri, 9 Mar 2001 13:34:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130588AbRCISeZ>; Fri, 9 Mar 2001 13:34:25 -0500
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: linux-usb-devel@lists.sourceforge.net
Date: Fri, 9 Mar 2001 18:35:48 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        david-b@pacbell.net (David Brownell),
        rmk@arm.linux.org.uk (Russell King), zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15017.7950.106874.276894@pizda.ninka.net> from "David S. Miller" at Mar 09, 2001 10:21:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bRjy-0005SS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Drivers can keep track of this kind of information themselves,
> and that is what I tell every driver author to do who complains
> of a lack of a "bus_to_virt()" type thing, it's just lazy
> programming.

I'd agree. There are _good_ reasons for having reverse mappings especially on
certain architectures, but thats for stuff like cache management. Its stuff
the drivers have no business poking their noses directly into

