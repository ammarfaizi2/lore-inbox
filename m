Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTGOSzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269463AbTGOSzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:55:01 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14989 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S269461AbTGOSy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:54:56 -0400
Date: Tue, 15 Jul 2003 21:09:41 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Christian Garbs [Master Mitch]" <mitch@mitch.h.shuttle.de>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Matrox framebuffer does not build
Message-ID: <20030715190941.GE17421@vana.vc.cvut.cz>
References: <20030714221642.GA23091@yggdrasil.mitch.h.shuttle.de> <Pine.LNX.4.44.0307142333280.17488-100000@phoenix.infradead.org> <20030715124034.GA25488@yggdrasil.mitch.h.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715124034.GA25488@yggdrasil.mitch.h.shuttle.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 02:40:34PM +0200, Christian Garbs [Master Mitch] wrote:
> On Mon, Jul 14, 2003 at 11:34:04PM +0100, James Simmons wrote:
> > 
> > > I tried to upgrade my 2.4.21 .config to 2.6.0-test1.  The Matrox
> > > framebuffer seems to create some problems: the kernel build fails.
> > 
> > :-( I will look into it. It worked before. 
> 
> Ooops, my bad:  I didn't set all of CONFIG_INPUT=y, CONFIG_VT=y,
> CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y as described in Known
> Gotchas in post-halloween-2.5.txt.
> 
> Now the kernel builds fine.  I'll try booting it later.

Or just remove it. palette array is write-only in stripped down matroxfb driver
which is present in 2.5.x kernels.
									Petr

