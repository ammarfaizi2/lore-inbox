Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUBJLcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUBJLcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:32:11 -0500
Received: from tuxhome.net ([217.160.179.19]:41139 "EHLO tuxhome.net")
	by vger.kernel.org with ESMTP id S265826AbUBJLcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:32:08 -0500
From: Markus Hofmann <markus@gofurther.de>
Organization: gofurther.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 - System clock runs too fast
Date: Tue, 10 Feb 2004 13:32:26 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402101332.26552.markus@gofurther.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together

I've a problem with my system clock. It runs too fast. In realtime 5 minutes 
my notebook runs 8 minutes. The BIOS-Time doesn't run.
With kernel 2.4.24 everything is ok but when I boot my new 2.6.2 the clock 
runs.

Could it be that the compiled speedstepping caused this problem?
Or is there an another causing?

My system: IBM A31p, Kernel 2.6.2, Debian unstable

I already tried "adjtimex --adjust", but I only get the following lines:

--------------
                                           --- current ---    -- suggested --
cmos time     system-cmos       2nd diff    tick      freq     tick      freq
1076412437     3618.069962    3618.069962   10000 -31571705
1076412444     3620.461976       2.392014   10000 -31571705
1076412451     3622.920983       2.459007   10000 -31571705     7536   1149088
1076412458     3625.488963       2.567980   10000 -31571705     7427   1326036
1076412467     3629.007896       3.518933   10000 -31571705     6476   1637419
adjtimex: Invalid argument
---------------

I hope someone can help me!

regards 
Markus
