Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276131AbRJCML3>; Wed, 3 Oct 2001 08:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276048AbRJCMLU>; Wed, 3 Oct 2001 08:11:20 -0400
Received: from h181s242a129n47.user.nortelnetworks.com ([47.129.242.181]:64684
	"HELO zcars0mt.") by vger.kernel.org with SMTP id <S276045AbRJCMLH>;
	Wed, 3 Oct 2001 08:11:07 -0400
Date: Wed, 3 Oct 2001 08:07:05 -0400
Message-Id: <200110031207.IAA18674@zcars0mt.>
To: linux-kernel@vger.kernel.org
From: Stephane Dudzinski <stephane@antefacto.com>
Subject: USB Issues on 2.4
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to bring your attention to some USB issues i experienced
with a USB mouse and normal PS/2 keyboard (not USB).

I installed a usb mouse on 2 systems, one being a pure intel with an
i810 chipset and the other being a via 686b chipset.

First one (the intel) behaves fine, all modules loading up okay and all
working smoothly.

Second one (via from hell) locks up the keyboard as soon as the usb-uhci
is loaded up. This behavior happened on both 2.4.9 and 2.4.10 final
kernels.

I've been pointed to some bios issues with ABIT boards (got a KT7A-RAID)
and especially IRQ sharing (got alot of PCI cards in the box).

I thought it might be useful to send this email.
Steph

-- 
__________________________________________
Stephane Dudzinski   Systems Administrator
a n t e f a c t o     t: +353 1 8586009
www.antefacto.com     f: +353 1 8586014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

