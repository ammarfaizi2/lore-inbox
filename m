Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKVLDn>; Wed, 22 Nov 2000 06:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKVLDe>; Wed, 22 Nov 2000 06:03:34 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:50523 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129295AbQKVLDR>; Wed, 22 Nov 2000 06:03:17 -0500
Date: Wed, 22 Nov 2000 12:40:57 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: 53c400 driver
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD6B@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.21.0011221239290.26803-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Dunlap, Randy wrote:

> JE's UHCI driver (drivers/usb/uhci.[hc]) uses
> nested_lock() and nested_unlock() for this.
> Maybe it could help.

I may should solve the nested spinlock issue.. It however doesn't solve
the 100Kb+ pile of spaghetti the code is.

I think I'll just start over. I have to do something in my spare time :)

> ~Randy

	Regards,


		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
