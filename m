Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQKAI7N>; Wed, 1 Nov 2000 03:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKAI7D>; Wed, 1 Nov 2000 03:59:03 -0500
Received: from CPE-61-9-148-61.vic.bigpond.net.au ([61.9.148.61]:2812 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129440AbQKAI66>; Wed, 1 Nov 2000 03:58:58 -0500
Date: Wed, 1 Nov 2000 20:00:36 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Subject: test10 dies very early in boot
Message-ID: <20001101200036.D655@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hardware:
	*	abit be6-2 mainboard
	*	533 celeron (not overclocked)
	*	192mb sdram
	* 	seagate 20gb ide disk (not on ata66 port)

compiler: gcc version 2.95.2 20000220 (Debian GNU/Linux)

it gets as far as uncompressing the kernel and trying to boot it.  no
further.  (doesn't get as far as displaying the 'Linux version ...'
message).  sysrq doesn't work (not suprising),  ctrl-alt-delete doesn't
work either.  reset button does work :-)

i did have an amateurish poke around comparing it to t10p7 (which boots
and runs fine on a near identical machine here at home), and all i could
turn up that seemed relevant was an a20 change in
arch/i386/boot/setup.S... and reversing that change didn't let it boot.
i have undoubtedly missed something.

i guess it had to happen eventually.  this is the first kernel i've had
trouble booting in 3 years or so.

that was with bzimage.. will try with zimage tomorrow.

2.4.x is extremely impressive.

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
