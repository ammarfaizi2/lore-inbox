Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTDHRJt (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTDHRJs (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:09:48 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3844 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261700AbTDHRJr (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 13:09:47 -0400
Date: Tue, 8 Apr 2003 21:21:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030408212119.A783@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030408165026.GA23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030408165026.GA23430@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Apr 08, 2003 at 05:50:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 05:50:26PM +0100, Matthew Wilcox wrote:
> Because it's possible to have multiple pci root bridges in the same
> pci domain.  This is true on at least HP's ia64 & parisc boxes.

I believe each PCI controller on these ia64/parisc boxes has its
own config space, and can support up to 256 bridged PCI buses, right?
Whether or not these PCI controllers share the same IO or MEM space is
irrelevant (because it's entirely implementation specific).

Ivan.
