Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRCIUJC>; Fri, 9 Mar 2001 15:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130661AbRCIUIx>; Fri, 9 Mar 2001 15:08:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12160 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130660AbRCIUIg>;
	Fri, 9 Mar 2001 15:08:36 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15017.14353.7980.55171@pizda.ninka.net>
Date: Fri, 9 Mar 2001 12:07:45 -0800 (PST)
To: David Brownell <david-b@pacbell.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Russell King <rmk@arm.linux.org.uk>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
In-Reply-To: <060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
	<00d401c0a5c6$f289d200$6800000a@brownell.org>
	<20010305232053.A16634@flint.arm.linux.org.uk>
	<15012.27969.175306.527274@pizda.ninka.net>
	<055e01c0a8b4$8d91dbe0$6800000a@brownell.org>
	<3AA91B2C.BEB85D8C@colorfullife.com>
	<060e01c0a8c6$ddbcc1e0$6800000a@brownell.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Brownell writes:
 > > Do lots of drivers need the reverse mapping? It wasn't on my todo list
 > > yet.
 > 
 > Some hardware (like OHCI) talks to drivers using those dma handles.

Drivers for such hardware will this keep track of the information
necessary to make this reverse mapping.

Later,
David S. Miller
davem@redhat.com
