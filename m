Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUHYSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUHYSpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUHYSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:45:40 -0400
Received: from verein.lst.de ([213.95.11.210]:449 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268250AbUHYSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:45:33 -0400
Date: Wed, 25 Aug 2004 20:45:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hans Reiser <reiser@namesys.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825184523.GA15419@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hans Reiser <reiser@namesys.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com> <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk> <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk> <412CDA68.7050702@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412CDA68.7050702@namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:28:56AM -0700, Hans Reiser wrote:
> I allowed myself to get talked out of a final top to bottom code audit, 
> and obviously that was a mistake.
> 
> It will probably take about 6 weeks.  Apologies for wasting your time 
> before that was done.

I don't think you'll get anywhere with auditing.  We need to write down
the semantics you want, define them at the VFS level and make sure
they're not conflicting with defined userspace semantics or kernel
assumptions.

I think you need to learn the basic distinction between the VFS layer
and a lowlevel filesystem driver.

