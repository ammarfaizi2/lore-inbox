Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUIBR0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUIBR0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIBR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:26:42 -0400
Received: from smtp.terra.es ([213.4.129.129]:10962 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S268207AbUIBR0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:26:41 -0400
Date: Thu, 2 Sep 2004 19:20:58 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: jgarzik@pobox.com, bhuey@lnxw.com, torvalds@osdl.org, tmv@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with
 reiser4)
Message-Id: <20040902192058.64f3ee03.diegocg@teleline.es>
In-Reply-To: <20040831205211.GA23395@nietzsche.lynx.com>
References: <20040826053200.GU31237@waste.org>
	<20040826075348.GT1284@nysv.org>
	<20040826163234.GA9047@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
	<20040831033950.GA32404@zero>
	<Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
	<413400B6.6040807@pobox.com>
	<20040831053055.GA8654@nietzsche.lynx.com>
	<4134131D.6050001@pobox.com>
	<20040831155613.2b25df1e.diegocg@teleline.es>
	<20040831205211.GA23395@nietzsche.lynx.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 31 Aug 2004 13:52:11 -0700 Bill Huey (hui) <bhuey@lnxw.com> escribió:

> As you can see the numbers are very fast for a general purpose system
> like that. Add that with their XIO framework for data propagation and

For the syscall case, I remember that they would be able to "batch" syscalls,
so this framework could have even better performance in some cases.
The good thing is that they didn't do it just for the sake of doing it
(like microkernel people) but to achieve their goals (SSI, etc)
