Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWAXTYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWAXTYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWAXTYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:24:31 -0500
Received: from mxsf29.cluster1.charter.net ([209.225.28.229]:45961 "EHLO
	mxsf29.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161030AbWAXTYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:24:31 -0500
X-IronPort-AV: i="4.01,214,1136178000"; 
   d="scan'208"; a="2034910958:sNHT25913962"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.32486.747771.407819@smtp.charter.net>
Date: Tue, 24 Jan 2006 14:24:22 -0500
From: "John Stoffel" <john@stoffel.org>
To: Andy Spiegl <kernelbug.Andy@spiegl.de>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
In-Reply-To: <20060124142151.GA3538@spiegl.de>
References: <20060124121542.GB13646@spiegl.de>
	<17366.13811.386903.438419@smtp.charter.net>
	<20060124142151.GA3538@spiegl.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Talk to ATI, it's their code doing something wrong.

Andy> Okay, knowing that for sure already helped me.

Well, I can't say for sure the problem is with ATI's code, but since
we can't see their code to debug it, it's effectively their problem.  

Andy> I thought that it's a bug in the kernel source because syslog
Andy> says "kernel BUG at mm/swap.c" and swap.c isn't part of fglrx.

That's doesn't matter, since the problem could be in the ATI code
which blows up in mm/swap.c

Andy> Too bad there is no free OpenGL driver - I hate to use closed
Andy> source stuff.

Umm... isn't there an MESA OpenGL driver stuff out there?  Prboably
not for your ATI card though.  If you can reproduce the crash without
any closed code, then people will try to help you.

John
