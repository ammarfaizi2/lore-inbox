Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWHSJ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWHSJ2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWHSJ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:28:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18567 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751679AbWHSJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:28:05 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [07/13]: jumbo frame support 2 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <20060818230457.GT29988@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <89aa13bbceac9f7580cfa29d3a05a236@coraid.com>
	 <1155941912.31543.21.camel@localhost.localdomain>
	 <20060818230457.GT29988@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 01:08:19 +0100
Message-Id: <1155946099.31543.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 19:04 -0400, ysgrifennodd Ed L. Cashin:
> On Fri, Aug 18, 2006 at 11:58:32PM +0100, Alan Cox wrote:
> Yes, I think that the patch author is used to doing ETH_ZLEN because
> of a bug in the e1000 driver where the short packets weren't getting
> padded.  I don't think I ever heard of a resolution to that issue, but
> I could change it back to "len" here.

It should have been resolved as uncleared packet tails are a security
hole. If not it needs fixing not aoe

