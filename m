Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUKLDIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUKLDIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 22:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUKLDIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 22:08:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:51433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261510AbUKLDIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 22:08:45 -0500
Date: Thu, 11 Nov 2004 19:08:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
In-Reply-To: <1100227848.5520.862.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411111903460.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>  <4192A9BF.2080606@conectiva.com.br>
 <4192ADF4.1050907@conectiva.com.br>  <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
  <1100211749.5510.753.camel@d845pe>  <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
  <1100215538.5876.779.camel@d845pe>  <Pine.LNX.4.58.0411111552030.2301@ppc970.osdl.org>
 <1100227848.5520.862.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Nov 2004, Len Brown wrote:
> 
> I agree 100%, and submit that the term "IRQ" fits this definition of a
> "stupid acronym".

There's a huge difference between an acronyn that is well-established, and 
one that is _totally_ made up, has no history, and is only used on one 
platform.

"irq" is a very traditional shorthand for "interrupt request", and anybody 
who has _ever_ worked with any OS on _any_ platform knows _exactly_ what 
it is.

In contrast, gsi has _zero_ meaning outside some small ACPI group. 

Trust me. Do a poll. 

The same way we don't call disks DASD devices do we not call interrupts 
gsi's.

And that "we" is not a "royal we".  It's a f*cking established _fact_. 
Type "irq" into google, and what's the first hit? In fact, EVERY SINGLE 
hit on the first page is relevant.

In contrast, type "gsi" into google, and NOT A SINGLE ONE has _anything_ 
to do with interrupts. Not the first one, not the tenth one.

So stop being idiotic.

		Linus
