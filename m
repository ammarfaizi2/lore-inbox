Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbULUXaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbULUXaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbULUXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:30:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:29831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261895AbULUXaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:30:02 -0500
Date: Tue, 21 Dec 2004 15:29:47 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, torvalds@osdl.org
Subject: Re: Cleanup PCI power states
Message-ID: <20041221232947.GA11236@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041217235051.GC29084@elf.ucw.cz> <20041221200333.GA9577@kroah.com> <20041221232510.GB1218@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221232510.GB1218@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:25:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This should reduce number of warnings in pci.c. It will still warn on
> > > comparison (because we are using __bitwise, but in fact we want
> > > something like "this is unique but arithmetic is still ok"), but that
> > > probably needs to be fixed in sparse.
> > > 
> > > Also killed "function does not return anything" warning.
> > > 
> > > Please apply,
> > 
> > What kernel tree is this against?  I get rejects in the second hunk.
> 
> Strange, it applied okay here over latest -bk. What tree should I
> generate it against?

Ah, ok, it's my fault, I have some changes by someone else in my tree.
I'll merge it in by hand.  Sorry about that.

greg k-h
