Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUKSRgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUKSRgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKSRgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:36:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:7345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261503AbUKSRgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:36:36 -0500
Date: Fri, 19 Nov 2004 09:36:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "Brown, Len" <len.brown@intel.com>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <20041119155705.GA2766@stusta.de>
Message-ID: <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30020B7225@hdsmsx401.amr.corp.intel.com>
 <20041119155705.GA2766@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Adrian Bunk wrote:
> 
> It's not a problem (I just wasn't sure, whether enabling APIC might 
> change something relevant.

It did. You no longer show the problem. No irq storm.

So can you disable APIC again, and just remove the non-relevant APIC print 
calls to get it to compile?

		Linus
