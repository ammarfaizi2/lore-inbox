Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbTDHRTd (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTDHRTd (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:19:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261883AbTDHRTb (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:19:31 -0400
Date: Tue, 8 Apr 2003 18:31:09 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       grundler@parisc-linux.org
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030408173109.GD23430@parcelfarce.linux.theplanet.co.uk>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030408165026.GA23430@parcelfarce.linux.theplanet.co.uk> <20030408212119.A783@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408212119.A783@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 09:21:19PM +0400, Ivan Kokshaysky wrote:
> On Tue, Apr 08, 2003 at 05:50:26PM +0100, Matthew Wilcox wrote:
> > Because it's possible to have multiple pci root bridges in the same
> > pci domain.  This is true on at least HP's ia64 & parisc boxes.
> 
> I believe each PCI controller on these ia64/parisc boxes has its
> own config space, and can support up to 256 bridged PCI buses, right?
> Whether or not these PCI controllers share the same IO or MEM space is
> irrelevant (because it's entirely implementation specific).

I think hardware _could_ work like that, but it's never set up to work
like that in practice.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
