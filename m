Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVFEV5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVFEV5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVFEV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 17:57:34 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:23507 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261612AbVFEV5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 17:57:32 -0400
Date: Sun, 05 Jun 2005 17:57:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: RT-V0.7.47-17 build fails
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <200506051757.26253.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I thought maybe I'd exersize this kernel, but a patch I thought was in 
seems not to have been, so I believe this is the 2nd time I've 
encountered this:

  CC      drivers/char/ipmi/ipmi_devintf.o
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of 
`class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of 
`class_simple_device_remove' makes integer from pointer without a 
cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to 
function `class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function `init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from 
incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing arg 1 of 
`class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing arg 1 of 
`class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing arg 1 of 
`class_simple_destroy' from incompatible pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1
make[2]: *** [drivers/char/ipmi] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

which of the 'git' patches fixes this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
