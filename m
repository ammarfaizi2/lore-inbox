Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUAFXCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUAFXCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:02:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:12049 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265420AbUAFXCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:02:40 -0500
Date: Tue, 6 Jan 2004 23:02:35 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Paul Misner <paul@misner.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <Pine.LNX.4.56.0312291610060.1041@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.44.0401062301380.21143-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've found that using "rivafb" does not work with my Geforce3, and from
> talking to various people on IRC about it I get the impression that rivafb
> is broken for any card newer than Geforce2. "vesafb" though works quite
> well with never NVidia cards.

The core code to the rivafb is lifted from a older X windows driver. I 
would need to grab the latest X server code which is very different.
 
> If I build my kernels with "rivafb" enabled I get a blank screen as well,
> but using "vesafb" all is fine (so is just plain vga=normal or
> vga=extended, but I prefer the fb console :)

Fixed in my latest patches.


