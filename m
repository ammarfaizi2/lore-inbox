Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRHOBWU>; Tue, 14 Aug 2001 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270988AbRHOBWK>; Tue, 14 Aug 2001 21:22:10 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:39440 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S270619AbRHOBWC>;
	Tue, 14 Aug 2001 21:22:02 -0400
Date: Tue, 14 Aug 2001 18:11:22 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Mode 5, UDMA, Dual Athy, ect....
Message-ID: <Pine.LNX.4.31.0108141756520.16362-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The AMD7411 driver code is in Alan Cox's patches and have been for a
while.  Because of limitations in getting the mode 5 timed correctly it is
restricted to mode 4.

General Mode 5 issues, support has been in Linux since June 5, 2000.

Mode 6 or Ultra133 is also supported; however, the HOST-Controllers are
not on the market.

The driver natively supports 48-bit LBA, but theses devices are not on the
market.

There is a whole lot of cool things to come, but there is an unknown delay
for getting patches into the stock kernel, thus you are best served to use
the -ac trees when it comes to latest and greatest for ATA/ATAPI support.

As many know that much of the cool stuff is scheduled for release upon
2.5.0, the reason is that early release means double the work since the
infrastructure require for the driver will not be considered presently.



Regards,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

