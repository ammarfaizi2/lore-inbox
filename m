Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTJWDaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 23:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJWDaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 23:30:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:36548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTJWDaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 23:30:05 -0400
Date: Wed, 22 Oct 2003 20:29:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>
Subject: Re: [BUG somewhere] 2.6.0-test8 irq.c, IRQ_INPROGRESS ?
In-Reply-To: <Pine.LNX.4.44.0310222021410.3151-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310222029100.3151-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Oct 2003, Linus Torvalds wrote:
> 
> It's not correct for "disable_irq_nosync()" users, and reverting it is the 
> right thing to do. Thanks for the report.

[ Btw, the 8390-based network drivers are likely the only thing to
  actually be able to trigger it, so thanks again for the good bug report. ]

		Linus

