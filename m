Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUJAABY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUJAABY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJAABY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:01:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:50351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269628AbUJAABP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:01:15 -0400
Date: Thu, 30 Sep 2004 17:05:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.9-rc2-mm4
Message-Id: <20040930170505.6536197c.akpm@osdl.org>
In-Reply-To: <1096586774l.5206l.1l@werewolf.able.es>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	<1096586774l.5206l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> On 2004.09.27, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/
> > 
> > - ppc64 builds are busted due to breakage in bk-pci.patch
> > 
> > - sparc64 builds are busted too.  Also due to pci problems.
> > 
> > - Various updates to various things.  In particular, a kswapd artifact which
> >   could cause too much swapout was fixed.
> > 
> > - I shall be offline for most of this week.
> > 
> 
> I have a 'little' problem. PS2 mouse is jerky as hell, an when you mismatch
> the protocol in X. Both in console and X.

The above sentence is a bit hard to decrypt.  Want to try again?

Is this new behaviour?  Is current -linus OK?  Was 2.6.9-rc2-mm3 OK?

> I'm lucky I have an usb mouse.
> 
> One other question. Isn't /dev/input/mice supposed to be a multiplexor
> for mice ? I think I remember some time when I could have both a PS2 and
> a USB mouse connected and X pointer followed both. Now if I boot with the
> USB mouse plugged, the PS2 one does not work. If I boot with usb unplugged
> and plug it after boot, both work; usb mouse works fine, and PS2 just
> jumps half screen each time I move it, and with big delays.
> 
> Something is broken in PS2 handling ?
> 
> NOTE: they are not really standard protocol mice, but trackballs; PS2 one is
> a Logitech TrackMan Marble FX, and the other a Cordless Trackman FX, usb.

Suitable people added to Cc: ;)
