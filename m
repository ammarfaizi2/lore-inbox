Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUJaOGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUJaOGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUJaOGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:06:44 -0500
Received: from smtp.terra.es ([213.4.129.129]:40085 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261627AbUJaOGm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:06:42 -0500
Date: Sun, 31 Oct 2004 15:06:37 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Lee Revell <rlrevell@joe-job.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, torvalds@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-Id: <20041031150637.6311a2ec.diegocg@teleline.es>
In-Reply-To: <1099175138.1424.18.camel@krustophenia.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	<200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
	<1099170891.1424.1.camel@krustophenia.net>
	<200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	<1099175138.1424.18.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 30 Oct 2004 18:25:38 -0400 Lee Revell <rlrevell@joe-job.com> escribió:

> I ageww it's a hard problem.  Right now there is massive pressure on
> Linux application developers to add features to catch up with MS and
> Apple.  This inevitably leads to bloat, we all know that efficiency is

I don't think it's so bad (ie: it could be _worse_)

There's some work going on to fix some "bloat problems" too, for example
the x.org people are working in a sort of xlib complement/replacement (i
don't know its real purpose) xcb which should help latency and code
size. Composite itself is a nice way of avoiding that apps redraw their
windows all the time. KDE "speed" is better is much better than a year 
ago, gnome 2.8 is also somewhat "faster" (compare nautilus in gnome 2.6
vs the one in 2.8). Openoffice 2.0 also will have some "performance
improvements" (see http://development.openoffice.org/releases/q-concept.html#4.1.3.Performance|outline
and http://development.openoffice.org/releases/q-concept.html#3.1.3.Performance|outline)

