Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTJTSkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJTSkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:40:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43280 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262708AbTJTSkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:40:23 -0400
Date: Mon, 20 Oct 2003 20:49:53 +0200
To: Peter Lieverdink <cafuego@coffee.cc.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Message-ID: <20031020184953.GA13000@hh.idb.hist.no>
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201340.48681.dev@sw.ru> <20031020024942.01094ff0.akpm@osdl.org> <20031020110539.GA14214@coffee.cc.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020110539.GA14214@coffee.cc.com.au>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 09:05:39PM +1000, Peter Lieverdink wrote:
> Re the new framebuffer code, it appears to not work on matroxfb.
> On bootup the console gets as far as:
> 
> ...
> found SMP MP-table at 000f4db0
> hm, page 000f4000 reserved twice.
> 
> And then it stops, whereas normally the framebuffer would kick in with a pengiun and continue booting.
> I boot the kernel with "video=matroxfb:vesa:0x192". When I disable it with "video=matroxfb:off" the system
> boots fine.
> 
2.6.0-test8-mm1 won't start with matroxfb for me either.
I have
video=matroxfb:vesa:0x1BB
This works with 2.6.0-test8, I get two nice penguins.
With mm1 all I get is lilo printing loading linux...
and then everything stops.  There isn't even a mode switch,
and no fsck on startup after using reset.

Helge Hafting
