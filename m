Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTFRQpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTFRQpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:45:10 -0400
Received: from [65.39.167.210] ([65.39.167.210]:59013 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S265361AbTFRQo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:44:28 -0400
Date: Wed, 18 Jun 2003 12:55:18 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: James Simmons <jsimmons@infradead.org>
cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <Pine.LNX.4.44.0306181736390.24449-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0306181252100.10083-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, James Simmons wrote:

> Date: Wed, 18 Jun 2003 17:38:50 +0100 (BST)
> From: James Simmons <jsimmons@infradead.org>
> To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
> Cc: Gerhard Mack <gmack@innerfire.net>, Robert Love <rml@tech9.net>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.5.71 - random console corruption
>
>
> > > Interestingly enough it's not console switching that does it.. it's
> > > scrolling also as I mentioned before it's not just with preempt enabled.
> > >
> > > I wonder if theres another problem somewhere?
> > I've got simmilar problem with 2.5.72, sometimes keyboard stops to respond (in
> > X windows). Mouse is usefull, all i have to do is restart Xwindows and
> > everything is running well.
>
> So scrolling is the issue. Which console drivers are you using?

Scrolling and screen clearing. If the machine is loaded the screen may
not clear all of the way.

I have the following enabled:
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y

I get this on starup:
atyfb: using auxiliary register aperture
atyfb: 3D RAGE IIC (AGP) [0x475a rev 0x7a] 8M SDRAM, 14.31818 MHz XTAL, 230 MHz

If you need me to try anything just ask.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

