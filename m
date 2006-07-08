Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWGHNjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWGHNjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWGHNjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:39:11 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51397 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S964829AbWGHNjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:39:10 -0400
Date: Sat, 8 Jul 2006 15:38:57 +0200 (MEST)
Message-Id: <200607081338.k68Dcvux007655@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: mikpe@it.uu.se, pavel@ucw.cz
Subject: Re: [BUG] 2.6.18-rc1 broke resume from APM suspend on Latitude CPi
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 21:47:37 +0000, Pavel Machek wrote:
>> Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
>> on my old Dell Latitude CPi laptop. At resume the disk
>> spins up and the screen gets lit, but there is no response
>> to the keyboard, not even sysrq. All other system activity
>> also appears to be halted.
>> 
>> I did the obvious test of reverting apm.c to the 2.6.17
>> version and fixing up the fallout from the TIF_POLLING_NRFLAG
>> changes, but it made no difference. So the problem must be
>> somewhere else.
>
>driver model changes?
>
>Can you retry with minimum drivers loaded, init=/bin/bash?

Did that, no change.
