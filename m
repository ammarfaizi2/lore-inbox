Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSHALzo>; Thu, 1 Aug 2002 07:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318707AbSHALzo>; Thu, 1 Aug 2002 07:55:44 -0400
Received: from tuscan1.lnk.telstra.net ([139.130.53.165]:48396 "EHLO
	ns.ecomrenaissance.com") by vger.kernel.org with ESMTP
	id <S318706AbSHALzn>; Thu, 1 Aug 2002 07:55:43 -0400
Message-Id: <v03110700b96ed14b8c89@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 1 Aug 2002 21:59:14 +1000
To: linux-kernel@vger.kernel.org
From: Bruce <bruce@toorak.com>
Subject: xconfig under 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make xconfig under 2.5.29 appears to be broken.
Errors occur when make tkconfig.tk

kconfig.tk
fs/partitions/Config.in:28 can't handle dep_bool/dep_mbool/dep_tristate
condition
[blah]
Error in startup script: invalid command name "clear_choices" while executing
"clear_choices"
(procedure "read_config" line 3)
invoked from within
"read_config .config"
(file "scripts/kconfig.tk" line 656)

Hope this helps

make menuconfig all works OK and the kernel partially builds.

Cheers,
Bruce Stephens.
Melbourne, Australia.


