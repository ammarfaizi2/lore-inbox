Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVF3EfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVF3EfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 00:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVF3EfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 00:35:20 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:56715 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262809AbVF3EfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 00:35:07 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 29 Jun 2005 21:34:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: Al Boldi <a1426z@gawab.com>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: SPAM: Re: XFS corruption during power-blackout
Message-ID: <367867.1263d54e6d6102a1bac5bc8924d7aeb8243f5cbbb3568fcaabb74308aeb953fe1c2f5773.ANY@taniwha.stupidest.org>
References: <20050629001847.GB850@frodo.suse.lists.linux.kernel> <200506290453.HAA14576@raad.intranet.suse.lists.linux.kernel> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org.suse.lists.linux.kernel> <42C2E0BC.8040508@xfs.org.suse.lists.linux.kernel> <254889.27725ab660aa106eb6acc07307d71ef1fbd5b6fd366aebef9e2f611750fbcb467e46e8a4.IBX@taniwha.stupidest.org.suse.lists.linux.kernel> <p73irzw3gjc.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73irzw3gjc.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 01:11:03AM +0200, Andi Kleen wrote:

> Don't know if the code hasn't bit rotted away and it also was a bit
> dumb. It was definitely there at some point.

It did rot away sadly but someone (speak up!) was working on a newer
version of this I just don't know how much time they've had to work on
this recently.

> But then a lot of ATA disks and SCSI don't support barriers.  Or at
> least the IDE barrier tests fails on several of my machines.

IDE has no barriers.  I thought the kernel was aware of this and
flushed when in those cases?  Does that not work?
