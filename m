Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWFLKpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWFLKpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWFLKpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:45:08 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:63917 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751822AbWFLKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:45:06 -0400
Date: Mon, 12 Jun 2006 06:42:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
To: "Keith Chew" <keith.chew@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606120644_MC3-1-C231-6148@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20f65d530606110328l5287cdf1ha4579f4120ed8ae9@mail.gmail.com>

On Sun, 11 Jun 2006 22:28:56 +1200, Keith Chew wrote:

> > Whether IO-APIC caused this bug or not, it's hard to say...
> >
> 
> We tested it with pci=noacpi, and it has been stable for 36 hours now.
> It looks like it has something to do with that.

Hmm...  could you post /proc/interrupts with and without pci=noacpi?
Also output of 'dmesg -s 999999 | grep -i irq' from both would help.

-- 
Chuck

