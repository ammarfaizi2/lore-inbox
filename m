Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVKAI7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVKAI7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKAI7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:59:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:11480 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965065AbVKAI7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:59:09 -0500
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do
	usb-handoff" breaks my powerbook
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1130815836.29054.420.camel@gaston>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	 <200510311741.56638.david-b@pacbell.net>
	 <1130812903.29054.408.camel@gaston>
	 <200510311909.32694.david-b@pacbell.net>
	 <1130815836.29054.420.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Nov 2005 09:28:14 +0000
Message-Id: <1130837294.9145.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-01 at 14:30 +1100, Benjamin Herrenschmidt wrote:
> Damn, those quirks should really be either more careful or be made
> platform specific if they are x86 junk workarounds.

USB handoff is fairly x86 specific. The x86 folks took great care to
handle back compatibility while Apple was content to just dump the users
and machines.

> > > It is illegal, whatever the platform is, to tap a PCI device MMIO like

Not "illegal" -> "invalid".

Please get that right as we have far too many incorrect uses of
"illegal" in publically visible printk calls. Illegal means "prohibited
by law".


