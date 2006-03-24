Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWCXL4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWCXL4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWCXL4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:56:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:43174 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932604AbWCXL4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:56:06 -0500
X-Authenticated: #14349625
Subject: 2.6.16-mm1 grub oddness
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 12:56:53 +0100
Message-Id: <1143201413.7741.53.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I'm seeing strange things with grub with this kernel.  After my box has
been up for a while, and I reboot, selecting a kernel to restart, upon
reboot, I sometimes (fairly often) get a blank screen staring at me
though I see grub doing it's thing.  Poking the power button results in
an immediate poweroff, not as if the kernel had panicked or whatnot very
early in boot.  Very odd, and never before seen.

(I was worried that my scheduler stuff was causing weird interactions,
but after testing, it's not me, it's there in virgin source.)

	-Mike

