Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274013AbRISGvq>; Wed, 19 Sep 2001 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274014AbRISGvg>; Wed, 19 Sep 2001 02:51:36 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:27787 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274013AbRISGv2>;
	Wed, 19 Sep 2001 02:51:28 -0400
Message-ID: <3BA84088.27698798@candelatech.com>
Date: Tue, 18 Sep 2001 23:51:52 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was running a network stress test (sending lots of 64 byte packets
on the DLINK 4-port NIC and two EEPRO-100 NICs.  This ran for 5 minutes,
and all was good (about 12Mbps of 64byte packets)..

Then, I re-started the test with 128 byte packets.  As soon as traffic
started, the whole machine locked up.  Couldn't even ping it from another
machine.  I had to hold down the power-switch for about 5 seconds before
it reset (ie it wasn't even listening to the power-down??)

I'm using the eepro100 driver that is included in the kernel, btw.  This
used to have a lockup problem, but I thought it was fixed...

I'm going to see if I can re-produce this.  If so, can someone suggest
a way to get more/better debugging information??

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
