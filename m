Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADBtl>; Wed, 3 Jan 2001 20:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRADBtb>; Wed, 3 Jan 2001 20:49:31 -0500
Received: from ns1.megapath.net ([216.200.176.4]:44046 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129267AbRADBtP>;
	Wed, 3 Jan 2001 20:49:15 -0500
Message-ID: <3A53D65F.8090900@megapathdsl.net>
Date: Wed, 03 Jan 2001 17:48:15 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: David Brownell <david-b@pacbell.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when it
			 isinserted into a Cardbus slot.
In-Reply-To: <3A53187B.9030601@megapathdsl.net> <032e01c07595$7be8b8c0$6600000a@brownell.org> <3A53C8AA.8060103@megapathdsl.net> <3A53D547.3070502@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There was also a big change to pci/setup_bus.c and pci/setup_bus.h
from Ivan Kokshaysky in test12-pre6.  Those changes seem like another
likely candidate.

	Miles



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
