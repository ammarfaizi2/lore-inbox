Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVKFWLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVKFWLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVKFWLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:11:21 -0500
Received: from [81.2.110.250] ([81.2.110.250]:17628 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932306AbVKFWLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:11:20 -0500
Subject: Re: Fwd: [RFC] IRQ type flags
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051106084012.GB25134@flint.arm.linux.org.uk>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Nov 2005 22:41:37 +0000
Message-Id: <1131316897.1212.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-06 at 08:40 +0000, Russell King wrote:
> Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect
> the property that the device would like.  The IRQ controller code
> should do its best to select the most appropriate supported mode.
> 
> Comments?

This is actually true of some x86 hardware in the EISA space where there
is a control register for level v edge that we sort of half deal with.


