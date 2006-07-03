Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWGCV62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGCV62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGCV61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:58:27 -0400
Received: from lucidpixels.com ([66.45.37.187]:5332 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932106AbWGCV6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:58:24 -0400
Date: Mon, 3 Jul 2006 17:58:24 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org
Subject: Linux SATA Support Question - Is the ULI M1575 chip supported?
Message-ID: <Pine.LNX.4.64.0607031756510.3342@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the source:

enum {
         uli_5289                = 0,
         uli_5287                = 1,
         uli_5281                = 2,

         uli_max_ports           = 4,

         /* PCI configuration registers */
         ULI5287_BASE            = 0x90, /* sata0 phy SCR registers */
         ULI5287_OFFS            = 0x10, /* offset from sata0->sata1 phy 
regs */
         ULI5281_BASE            = 0x60, /* sata0 phy SCR  registers */
         ULI5281_OFFS            = 0x60, /* offset from sata0->sata1 phy 
regs */
};

However, in the manual for this motherboard it states it has a ULI M1575, 
can anyone comment?

http://us.dfi.com.tw/Upload/Manual/90800601.pdf

