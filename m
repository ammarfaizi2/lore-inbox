Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUKSSwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUKSSwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 13:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUKSSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 13:52:21 -0500
Received: from fmr14.intel.com ([192.55.52.68]:11209 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261536AbUKSSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 13:52:18 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30020B7225@hdsmsx401.amr.corp.intel.com>
	 <20041119155705.GA2766@stusta.de>
	 <Pine.LNX.4.58.0411190935210.2222@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1100890266.987.124.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Nov 2004 13:51:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 12:36, Linus Torvalds wrote:
> 
> On Fri, 19 Nov 2004, Adrian Bunk wrote:
> >
> > It's not a problem (I just wasn't sure, whether enabling APIC might
> > change something relevant.
> 
> It did. You no longer show the problem. No irq storm.
> 
> So can you disable APIC again, and just remove the non-relevant APIC
> print
> calls to get it to compile?

I think if you boot the kernel you have with "nolapic" that will be a
valid test for us to examine PIC mode.

thanks,
-Len

ps. I'm curious why you were running with !IOAPIC kernel suport on a
system which has an IOAPIC.


