Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVKFW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVKFW3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVKFW3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:29:41 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16534 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932270AbVKFW3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:29:41 -0500
Subject: Re: Fwd: [RFC] IRQ type flags
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051106221643.GB6274@flint.arm.linux.org.uk>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
	 <1131316897.1212.61.camel@localhost.localdomain>
	 <20051106221643.GB6274@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Nov 2005 22:59:58 +0000
Message-Id: <1131317998.1212.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-06 at 22:16 +0000, Russell King wrote:
> > This is actually true of some x86 hardware in the EISA space where there
> > is a control register for level v edge that we sort of half deal with.
> 
> Thanks Alan.  Can I assume you're happy with the patch, even if x86
> currently ignores the flags?

I'm certainly happy with it. Both the APIC and EISA IRQ control
registers could even be made to honour it if anyone ever needed to.

Should platforms that don't support the flags be patched to error
requests they don't support however ?

Alan

