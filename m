Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVECCnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVECCnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 22:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVECCnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 22:43:06 -0400
Received: from ozlabs.org ([203.10.76.45]:57985 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261306AbVECCnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 22:43:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17014.59016.336852.31119@cargo.ozlabs.ibm.com>
Date: Tue, 3 May 2005 12:48:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
In-Reply-To: <873bt5xf9v.fsf@blackdown.de>
References: <42748B75.D6CBF829@tv-sign.ru>
	<20050501023149.6908c573.akpm@osdl.org>
	<87vf61kztb.fsf@blackdown.de>
	<1115079230.6155.35.camel@gaston>
	<873bt5xf9v.fsf@blackdown.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder writes:

> BTW, xmon doesn't work for me.  'echo x > /proc/sysrq-trigger' gives
> me a :mon> prompt but I can't enter any commands.

We don't have polled interrupts-off input methods for USB keyboards.
If you get a "stealth" serial port for your G5 you can run xmon over
that.

Paul.
