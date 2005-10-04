Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVJDD2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVJDD2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVJDD2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:28:33 -0400
Received: from xenotime.net ([66.160.160.81]:37282 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932341AbVJDD2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:28:32 -0400
Date: Mon, 3 Oct 2005 20:28:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Diego de Estrada <diego1609@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-Id: <20051003202831.64d6e5a6.rdunlap@xenotime.net>
In-Reply-To: <5dc44ec70510031959w1f4adfcbh395535ade34a357d@mail.gmail.com>
References: <20051002170318.GA22074@home.fluff.org>
	<20051002103922.34dd287d.rdunlap@xenotime.net>
	<5dc44ec70510031959w1f4adfcbh395535ade34a357d@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005 23:59:16 -0300 Diego de Estrada wrote:

> On 10/2/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
> >
> > > If release_resource() is passed a NULL resource
> > > the kernel will OOPS.
> >
> > does this actually happen?  you are fixing a real oops?
> > if so, what driver caused it?
> 
> The point is: no driver should make the kernel OOPS. Thanks Ben.

I understand that sentiment, but if a driver is bad,
we generally want to know about that rather than paste
(or paper) over it on a continuous basis.


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
