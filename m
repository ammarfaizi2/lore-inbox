Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKPLyu>; Thu, 16 Nov 2000 06:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQKPLyk>; Thu, 16 Nov 2000 06:54:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7059 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129449AbQKPLyU>;
	Thu, 16 Nov 2000 06:54:20 -0500
Date: Thu, 16 Nov 2000 03:07:30 -0800
Message-Id: <200011161107.DAA10681@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: adam@yggdrasil.com
CC: linux-kernel@vger.kernel.org, willy@meta-x.org, wtarreau@yahoo.fr
In-Reply-To: <200011161110.DAA13775@baldur.yggdrasil.com> (adam@yggdrasil.com)
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
In-Reply-To: <200011161110.DAA13775@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 16 Nov 2000 03:10:14 -0800

   >Sorry, I don't like this change.

	   Can you at least add the MODULE_DEVICE_TABLE declaration
   and the pci_device_id table that it refers to, even if the code
   does not directly reference it?  (You can make it as __initdata
   rather than __devinitdata, since it can safely be thrown away.)
   That was automatic PCI ID recognition will work.

Feel free to send me a patch which does this.  No problem.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
