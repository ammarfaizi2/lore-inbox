Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVHBEu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVHBEu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 00:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVHBEu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 00:50:58 -0400
Received: from CYRUS.andrew.cmu.edu ([128.2.10.175]:39346 "EHLO
	mail-fe5.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S261183AbVHBEu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 00:50:56 -0400
Message-ID: <42EEFB9B.10508@andrew.cmu.edu>
Date: Tue, 02 Aug 2005 00:50:35 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org>
In-Reply-To: <20050801204245.GC17258@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
 > On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
 >>The tradeoff is a realistic 4.4% power savings vs a 300% increase in
 >>the minimum sleep period.  A user will see zero power savings if they
 >>have a USB mouse (probably 99% of desktops).  On top of that, we can
                                     ^^^^^^^^

 > Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
 > the places where power consumption savins matters most, it's usually
 > quite possible to function without needing any USB devices.  The 90%
 > figure isn't at all right; in fact, it may be that over 90% of the
 > laptops still use PS/2 mice and keyboards.

Yes, laptops are mostly PS/2, which is why I only claimed a statistic 
for desktops.  Desktops pretty much all use USB mice now.  If 250Hz were 
only being sold as an option for laptops, we could leave it at that, yet 
its being pushed as a default that's "good for everyone".  For desktops 
this is not currently true at all.  By the time USB is fixed to do power 
saving, we'll probably have a working tick-skipping patch which makes 
the whole HZ argument moot.

  - Jim Bruce
