Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269505AbRHCR1C>; Fri, 3 Aug 2001 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269495AbRHCR0w>; Fri, 3 Aug 2001 13:26:52 -0400
Received: from corp.tivoli.com ([216.140.178.60]:51330 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S269505AbRHCR0h>;
	Fri, 3 Aug 2001 13:26:37 -0400
Message-ID: <3B6ADBA7.2FC0AE2A@bellsouth.net>
Date: Fri, 03 Aug 2001 13:13:12 -0400
From: Paul <pstroud@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mulitple 3c509 cards 2.4.x Kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a x86 server with multiple(2) 3c509 cards. When I build the 3c509
driver
into the kernel. It will only pick up a single card. The cards are
NOT in pnp mode
according to isapnp on boot. I have added:

append = "ether=3,0x300,0,0,eth0 ether=10,0x280,0,0,eth1"

to the lilo file and still only one card is detected. The io ports and
irq's come direct
from /proc with  the 2.2.13 kernel in place. There are no messages about
anything
failing, only the message that the one card was found. It appears the
card on the
higher io(0x300) is the only one that is ever found.

The machine is an old p100 with no no other cards except the video card.
I have
tested this with every kernel from 2.4.0-testxx to the 2.4.6 kernel. I
see nothing in
the changelog for 2.4.7 that leads me to believe it is fixed in that
kernel.

Please CC me on any reply or request as I am not a member of the list.

Thanks,
Paul Stroud

