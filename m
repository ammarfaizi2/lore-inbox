Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVKAVMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVKAVMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVKAVMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:12:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:64420 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751237AbVKAVMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:12:37 -0500
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do
	usb-handoff" breaks my powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1130837294.9145.80.camel@localhost.localdomain>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	 <200510311741.56638.david-b@pacbell.net>
	 <1130812903.29054.408.camel@gaston>
	 <200510311909.32694.david-b@pacbell.net>
	 <1130815836.29054.420.camel@gaston>
	 <1130837294.9145.80.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 08:09:45 +1100
Message-Id: <1130879386.29054.457.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 09:28 +0000, Alan Cox wrote:
> On Maw, 2005-11-01 at 14:30 +1100, Benjamin Herrenschmidt wrote:
> > Damn, those quirks should really be either more careful or be made
> > platform specific if they are x86 junk workarounds.
> 
> USB handoff is fairly x86 specific. The x86 folks took great care to
> handle back compatibility while Apple was content to just dump the users
> and machines.

What is this comment supposed to mean ? Backward compatiblity on Macs is
very high, thanks to mostly software not relying on stupid & broken
hardware implementation details...

> Not "illegal" -> "invalid".
> 
> Please get that right as we have far too many incorrect uses of
> "illegal" in publically visible printk calls. Illegal means "prohibited
> by law".

Oh well, whatever you say..

Ben.


