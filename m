Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTKWFJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 00:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTKWFJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 00:09:38 -0500
Received: from colin2.muc.de ([193.149.48.15]:63505 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263267AbTKWFJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 00:09:38 -0500
Date: 23 Nov 2003 06:10:11 +0100
Date: Sun, 23 Nov 2003 06:10:11 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, md@Linux.IT, linux-kernel@vger.kernel.org
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123051011.GA92830@colin2.muc.de>
References: <m3vfpbiwir.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0311222022120.2379-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311222022120.2379-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 08:23:16PM -0800, Linus Torvalds wrote:
> 
> On Sun, 23 Nov 2003, Andi Kleen wrote:
> > 
> > It's a long standing bug in how we handle VIA on board devices in ACPI.
> > It was a big problem on x86-64 too until I cheated and used only
> > PIC mode when there is a VIA southbridge.
> 
> That doesn't explain the lack of autodetection, and the early irq15 
> registration.
> 
> That would explain why no interrupts make it at all, but why do we not 
> even probe for irq15 here?

It's easy to test. does it work when booted with "noapic" ? 

-Andi
