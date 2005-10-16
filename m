Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJPGBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJPGBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 02:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJPGBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 02:01:51 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:21427 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751290AbVJPGBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 02:01:51 -0400
Subject: 2.6.14-rc4-rt6, depmod
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Sat, 15 Oct 2005 23:01:52 -0700
Message-Id: <1129442512.7978.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, I'm getting this after building 2.6.14-rc4-rt6:

WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/char/hangcheck-timer.ko needs unknown symbol do_monotonic_clock
WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/input/gameport/gameport.ko needs unknown symbol i8253_lock
WARNING: /lib/modules/2.6.13-0.13.rrt.rhfc4.ccrmasmp/kernel/drivers/input/joystick/analog.ko needs unknown symbol i8253_lock

BTW, rt5 "settles" down after a while and I don't get timer problems
anymore (ie: fast key repeats and random screensaver activations). It
does right after a reboot (but I have not tried too many times). 

-- Fernando


