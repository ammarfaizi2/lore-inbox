Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbSLKRtW>; Wed, 11 Dec 2002 12:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbSLKRtW>; Wed, 11 Dec 2002 12:49:22 -0500
Received: from [217.167.51.129] ([217.167.51.129]:24002 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267241AbSLKRtV>;
	Wed, 11 Dec 2002 12:49:21 -0500
Subject: Re: patch for aty128fb.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0212110635110.2617-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212110635110.2617-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 19:01:56 +0100
Message-Id: <1039629716.3539.51.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 15:42, James Simmons wrote:
> 
> > Currently it can only put one rage 128 chip to sleep, but that is ok
> > for now since I've never seen a laptop with two rage 128 chips yet. :)
> > The generic device model will ultimately give us a better way to
> > handle sleep/wakeup.
> 
> Actually I started to looking into doing that. I noticed struct
> pci_driver having a resume and suspend function. Is this related? I just
> started to looking into the new PM code.

It's +/- related, but pls don't play with that now, I need to dig into
it in much details myself, I don't think I'll use the pci callbacks
anyway.

Ben.

