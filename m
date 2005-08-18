Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVHROYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVHROYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVHROYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:24:08 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:15524 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932102AbVHROYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:24:07 -0400
X-ORBL: [63.205.185.3]
Date: Thu, 18 Aug 2005 07:23:59 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>,
       Henrik Brix Andersen <brix@gentoo.org>, Olaf Hering <olh@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050818142359.GB17145@taniwha.stupidest.org>
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org> <20050813234322.GA30563@suse.de> <1123978962.13656.21.camel@sponge.fungus> <20050814084715.GA15668@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814084715.GA15668@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 09:47:15AM +0100, Christoph Hellwig wrote:

> Looks like people never learn.  We had horrible problems with devfs
> because it decided to overload existing name fields, but the udev
> brigade does the same idiocy again..

It's not too late to fix this.  We can add a new field and rename the
old one with minimal effort.
