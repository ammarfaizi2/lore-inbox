Return-Path: <linux-kernel-owner+w=401wt.eu-S933222AbWLaUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbWLaUqO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933220AbWLaUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:46:14 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47665
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933219AbWLaUqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:46:13 -0500
Date: Sun, 31 Dec 2006 12:46:12 -0800 (PST)
Message-Id: <20061231.124612.21926488.davem@davemloft.net>
To: hch@infradead.org
Cc: dmk@flex.com, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061231154103.GA7409@infradead.org>
References: <45978CE9.7090700@flex.com>
	<20061231.024917.59652177.davem@davemloft.net>
	<20061231154103.GA7409@infradead.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 31 Dec 2006 15:41:03 +0000

> On Sun, Dec 31, 2006 at 02:49:17AM -0800, David Miller wrote:
> > Am I the only person who sees something very wrong with this?
> 
> No, I completely agree with you on this.
> 
> If firmworks really wants to have a spearate filesystem that's fine.
> But please start with the ppc or sparc code and massage it into a
> a separate filesystem before adding support for a new platform.
> 
> The last thing we need is more duplication.
> 
> In case anyone wants to start this based on ppc I'd gladfully help
> to test this on pmac (32 and 64bit) and cell (64 bit).

Thanks for the vote of sanity Christoph.

I'm happy to test on sparc64 of course too :-)
