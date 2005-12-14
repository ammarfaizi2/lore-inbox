Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVLNX0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVLNX0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVLNX0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:26:23 -0500
Received: from xenotime.net ([66.160.160.81]:27802 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965084AbVLNX0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:26:22 -0500
Date: Wed, 14 Dec 2005 15:26:16 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][expample patch] Make the kernel -Wshadow clean ?
In-Reply-To: <20051214232226.GD31955@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0512141525500.29143@shark.he.net>
References: <200512150019.57124.jesper.juhl@gmail.com>
 <20051214232226.GD31955@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, Russell King wrote:

> On Thu, Dec 15, 2005 at 12:19:57AM +0100, Jesper Juhl wrote:
> > -			void (*dtor)(struct page *page);
> > +			void (*dtor)(struct page *pge);
>
> Note that this one just needs to be:
> 			void (*dtor)(struct page *);

I would rather see <shadowed> names there.

-- 
~Randy
