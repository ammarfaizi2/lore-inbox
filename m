Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWAKR2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWAKR2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWAKR2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:28:15 -0500
Received: from cabal.ca ([134.117.69.58]:25767 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751701AbWAKR2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:28:14 -0500
Date: Wed, 11 Jan 2006 12:27:11 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <matthew@wil.cx>, hch@lst.de, kyle@parisc-linux.org,
       akpm@osdl.org, carlos@parisc-linux.org, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060111172711.GB28018@quicksilver.road.mcmartin.ca>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca> <20060109141355.GA22296@lst.de> <20060110150141.GE28306@quicksilver.road.mcmartin.ca> <20060110151547.GB17621@lst.de> <20060110163943.GY19769@parisc-linux.org> <20060111144600.6e75fad4.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111144600.6e75fad4.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 02:46:00PM +1100, Stephen Rothwell wrote:
> > Andi's now dropped his opposition, so I think we're fine.
> 
> And I think DaveM got tired :-)
>

I think we can all agree that having one macro, which is more
easily controlled, and doesn't require large amounts of grep work
for an arch maintainer to find (ab)uses of. Is a far more desireable 
solution over every piece of code that needs to do it abusing various
test_thread_flag and such.

Cheers,
	Kyle
