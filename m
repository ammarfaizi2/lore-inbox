Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSJTSzY>; Sun, 20 Oct 2002 14:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSJTSzY>; Sun, 20 Oct 2002 14:55:24 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:61967 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id <S263997AbSJTSzY>; Sun, 20 Oct 2002 14:55:24 -0400
Date: Sun, 20 Oct 2002 09:33:01 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: PnP compile problem on 2.5.44
Message-ID: <20021020073301.GA30611@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I dunno if this is an idiotic configuration but I made the following choices when configuring the kernel:

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_DEBUG=y
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

The result when compiling was as follows:
drivers/pnp/compat.c: In function `pnp_find_card':
drivers/pnp/compat.c:39: `isapnp_cards' undeclared (first use in this function)
drivers/pnp/compat.c:39: (Each undeclared identifier is reported only once
drivers/pnp/compat.c:39: for each function it appears in.)

Regards,
David

PS
Please CC me on any eventual replies since I'm not subscribed to the list
