Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130953AbRCFFyA>; Tue, 6 Mar 2001 00:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130954AbRCFFxv>; Tue, 6 Mar 2001 00:53:51 -0500
Received: from www.wen-online.de ([212.223.88.39]:65294 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130953AbRCFFxq>;
	Tue, 6 Mar 2001 00:53:46 -0500
Date: Tue, 6 Mar 2001 06:53:45 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.3.95.1010305133108.884B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0103060647240.1815-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Richard B. Johnson wrote:

> On Mon, 5 Mar 2001, Mike Galbraith wrote:
>
> > Are you saying that the initrd is broken again as well?  (having
> > trouble understanding the problem.. don't see why you need the
> > loop device or rather how its being busted is connected to your
> > [interpolation] difficulty in creating a new initrd)
> >
> > 	-EAGAIN ;-)
> >
>
> The initial RAM disk image is created using the loop device. You
> can create a RAM disk image for initrd by using the ram device.
> However, that doesn't work once the system has been booted off
> it (try it, be ready for a complete hang).

That's news to me.  My test images were created without using the
loop device, and my box boots just fine.

	-Mike

