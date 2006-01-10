Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWAJPQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWAJPQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAJPQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:16:06 -0500
Received: from verein.lst.de ([213.95.11.210]:6828 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751124AbWAJPQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:16:02 -0500
Date: Tue, 10 Jan 2006 16:15:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, carlos@parisc-linux.org,
       willy@parisc-linux.org, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060110151547.GB17621@lst.de>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca> <20060109141355.GA22296@lst.de> <20060110150141.GE28306@quicksilver.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110150141.GE28306@quicksilver.road.mcmartin.ca>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:01:41AM -0500, Kyle McMartin wrote:
> I agree, I'm really just trying to shepard this home so we don't have
> to maintain it out of tree. I'm not overly attached to the code, if
> I can make parisc64 work with your compat signal bits, I'll be
> just as happy.
> 
> The one thing from this patchset I'd like to keep is the is_compat_task()
> as it does provide nice cleanups 

Yes, the is_compat_task helper is a nice thing to have.  I haven't
needed it for the signal bits I've done yet, but it's also useful
elsewhere.  But IIRC someone vehemently opposed it in the last round
of discussion.

