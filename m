Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbTLKUhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbTLKUhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:37:33 -0500
Received: from pop.gmx.de ([213.165.64.20]:18628 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265465AbTLKUhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:37:31 -0500
X-Authenticated: #20450766
Date: Thu, 11 Dec 2003 21:05:05 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test11: PCMCIA] i82365: No such device...
In-Reply-To: <Pine.LNX.4.33.0312111021230.1130-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.44.0312112102290.4669-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Guennadi Liakhovetski wrote:

> On Thu, 11 Dec 2003, Russell King wrote:
>
> > On Thu, Dec 11, 2003 at 09:37:38AM +0100, Guennadi Liakhovetski wrote:
> > > 00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 07)
> >           ^^^^^^^^^^^^^^
> >
> > Cardbus is 32-bit, so you need to use yenta not i82365.
>
> Ok, thanks, will try. I knew that in general, was just confused by the
> fact, that it worked under 2.4 and that it says "16bit CardBus" in BIOS...

Yep, Yenta worked. Thanks again.

Guennadi

P.S. looks like my initial message _somehow_ managed to get twice to the
list... No idea how this happened. Sorry anyway.
---
Guennadi Liakhovetski



