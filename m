Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272230AbTG3UXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272232AbTG3UXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:23:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42973 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S272230AbTG3UXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:23:35 -0400
Date: Wed, 30 Jul 2003 16:22:25 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
Message-ID: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I built ipsec-tools against the 2.6.0-test2-mm1 includes and am *so*
close to getting it to work...

I'm getting odd errors from racoon:

INFO: isakmp.c:797:isakmp_ph1begin_i(): initiate new phase 1
	negotiation: 9.30.62.131[500]<=>9.51.94.26[500]
INFO: isakmp.c:802:isakmp_ph1begin_i(): begin Identity Protection mode.
INFO: isakmp.c:2418:log_ph1established(): ISAKMP-SA established
	9.30.62.131[500]-9.51.94.26[500] spi:36dbc14ce81d5d28:dc42216efd6549d4
INFO: isakmp.c:941:isakmp_ph2begin_i(): initiate new phase 2 negotiation:
	9.30.62.131[0]<=>9.51.94.26[0]
modprobe: FATAL: Module ripemd160 not found.
modprobe: FATAL: Module cast128 not found.
modprobe: FATAL: Module lzs not found.
modprobe: FATAL: Module lzjh not found.
modprobe: FATAL: Module xfrm_type_2_50 not found.
modprobe: FATAL: Module ripemd160 not found.
modprobe: FATAL: Module cast128 not found.
modprobe: FATAL: Module lzs not found.
modprobe: FATAL: Module lzjh not found.
modprobe: FATAL: Module xfrm_type_2_50 not found.
ERROR: pfkey.c:209:pfkey_handler(): pfkey UPDATE failed:
	 No buffer space available
ERROR: pfkey.c:209:pfkey_handler(): pfkey ADD failed: No buffer space available

all the ipsec and crypto stuff is modular, for the nonce, until I figure
what I need/want.

most of the module not found messages are fine, its xfrm_type_2_50 that
I'm worried about... What am I missing ?
-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
