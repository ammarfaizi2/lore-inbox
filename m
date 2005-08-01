Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVHAVkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVHAVkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVHAViQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:38:16 -0400
Received: from thunk.org ([69.25.196.29]:37587 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261295AbVHAVfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:35:36 -0400
Date: Mon, 1 Aug 2005 16:42:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801204245.GC17258@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	James Bruce <bruce@andrew.cmu.edu>,
	David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
	Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE4B4A.80602@andrew.cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
> 
> The tradeoff is a realistic 4.4% power savings vs a 300% increase in the 
> minimum sleep period.  A user will see zero power savings if they have a 
> USB mouse (probably 99% of desktops).  On top of that, we can throw in 
> Con's disturbing AV benchmark results (1).  As a result, some of us 
> don't think 250HZ is a great tradeoff to make _for_the_default_value_.

Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
the places where power consumption savins matters most, it's usually
quite possible to function without needing any USB devices.  The 90%
figure isn't at all right; in fact, it may be that over 90% of the
laptops still use PS/2 mice and keyboards.

						- Ted
