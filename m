Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTIYLwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTIYLwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:52:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:28370 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261811AbTIYLwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:52:42 -0400
Date: Thu, 25 Sep 2003 13:52:37 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the
 same symbols
In-Reply-To: <20030925123831.A10840@infradead.org>
Message-ID: <Pine.LNX.4.31.0309251347490.21797-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 01:33:53PM +0200, Armin Schindler wrote:
> > The legacy eicon driver in drivers/isdn/eicon is the old one and will be
> > removed as soon as all features went to the new driver.
> > Anyway this old driver was never meant to be non-module.
>
> What about just killing it off?  If users really want the old one
> on 2.6 you can put up a tarball for them somewhere.
>
> The driver is so horrinly ugly that it better goes away sooner than
> later..

Oh thank you! Okay, it's old, too old.

It's not just "the old one", this driver still supports more than 4 ISDN
cards, which are not yet supported by the other driver.

But maybe you are right...

Armin


