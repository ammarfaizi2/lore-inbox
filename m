Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUDRJ4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 05:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbUDRJ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 05:56:43 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:7686 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264154AbUDRJ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 05:56:37 -0400
Date: Sun, 18 Apr 2004 18:00:40 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-mm6
In-Reply-To: <20040414230413.4f5aa917.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404181756430.5049@donald.themaw.net>
References: <20040414230413.4f5aa917.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.2, required 8,
	IN_REP_TO, NO_REAL_NAME, REFERENCES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like something was missed here.

arch/sparc64/kernel/signal.c: In function `do_signal':
arch/sparc64/kernel/signal.c:627: warning: passing arg 2 of 
`get_signal_to_deliver' from incompatible pointer type
arch/sparc64/kernel/signal.c:627: warning: passing arg 3 of 
`get_signal_to_deliver' from incompatible pointer type
arch/sparc64/kernel/signal.c:627: error: too few arguments to function 
`get_signal_to_deliver'

Anyone got any suggestions?

