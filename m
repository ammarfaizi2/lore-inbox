Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265117AbSJaCxG>; Wed, 30 Oct 2002 21:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265118AbSJaCxG>; Wed, 30 Oct 2002 21:53:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21946 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265117AbSJaCxG>; Wed, 30 Oct 2002 21:53:06 -0500
Date: Wed, 30 Oct 2002 18:56:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <3396299720.1036004191@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some warnings, if anyone's bored, and wants something to fix ;-)

drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
drivers/base/base.h:64: warning: `class_hotplug' defined but not used
mm/slab.c: In function `cache_reap':
mm/slab.c:2061: warning: deprecated use of label at end of compound statement
mm/vmscan.c: In function `shrink_caches':
mm/vmscan.c:733: warning: duplicate `const'
mm/swap_state.c: In function `free_pages_and_swap_cache':
mm/swap_state.c:299: warning: duplicate `const'
drivers/net/starfire.c: In function `netdev_close':
drivers/net/starfire.c:1848: warning: unsigned int format, different type arg (arg 2)
drivers/net/starfire.c:1848: warning: unsigned int format, different type arg (arg 2)
drivers/net/starfire.c:1855: warning: unsigned int format, different type arg (arg 2)
drivers/net/starfire.c:1855: warning: unsigned int format, different type arg (arg 2)
net/ipv4/route.c: In function `ip_rt_init':
net/ipv4/route.c:2544: warning: implicit declaration of function `xfrm_init'

I think the starfire ones will need PAE turned on in the config to
trigger it (printing a phys ptr using an unsigned long format?)

M.


