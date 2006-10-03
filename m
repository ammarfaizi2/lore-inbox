Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbWJCWhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbWJCWhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWJCWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:37:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5766 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030625AbWJCWhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:37:14 -0400
Message-ID: <4522E618.2070004@garzik.org>
Date: Tue, 03 Oct 2006 18:37:12 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #2
References: <20061003220732.GE2785@slug> <4522E0E0.9020404@garzik.org> <20061003222910.GJ2785@slug>
In-Reply-To: <20061003222910.GJ2785@slug>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> My bad, I've mixed your proposal and Matthew's, isn't this just a
> matter of:
> s/ARCH_VALIDATE_PCI_IRQ/ARCH_VALIDATE_IRQ/ ?
> 
> I'll look if there's some non-PCI code that might check the irq's value
> and thus might benefit from this.

The irq value comes from the PCI subsystem...  The PCI subsystem should 
validate it.

	Jeff


