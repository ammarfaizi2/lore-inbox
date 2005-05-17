Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVEQPuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEQPuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVEQPuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:50:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:12708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEQPrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:47:16 -0400
Date: Tue, 17 May 2005 08:48:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <42899797.2090702@sw.ru>
Message-ID: <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Kirill Korotaev wrote:
> 
> BTW, why NMI watchdog is disabled by default? We constantly making it on 
> by default in our kernels and had no problems with it.
> I send a patch attached which tunes NMI watchdog by config option...

I really don't want NMI watchdogs enabled by default. It's historically 
been _very_ fragile on some systems. Whether that has been due to harware 
or sw bugs, I dunno, but it's definitely been problematic.

		Linus
