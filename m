Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSIWS2c>; Mon, 23 Sep 2002 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSIWS1f>; Mon, 23 Sep 2002 14:27:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:19982 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261367AbSIWS0q>; Mon, 23 Sep 2002 14:26:46 -0400
Date: Mon, 23 Sep 2002 20:31:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@suse.cz>, Richard Henderson <rth@twiddle.net>,
       Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020923183157.GD11237@atrey.karlin.mff.cuni.cz>
References: <20020922013346.A39@toy.ucw.cz> <Pine.LNX.3.95.1020923090547.2963B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020923090547.2963B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's a problem with a 'general purpose' compiler that wants to
> > > be "all things" to all people. If somebody made a gcc-compatible
> > > compiler, tuned to the ix86 characteristics, I think we could
> > > cut the extra instructions by at least 1/2, maybe more.
> > 
> > Remember pgcc? 
> > 
> > And btw cutting instructions by 1/2might look nice but unless you can
> > keep it as fast as it was, its useless.
> > 								Pavel
> > -- 
> Yes, but to see the affect of cutting down the instruction length, you
> need to make benchmarks that emulate running 'forever'. Many bench-

Specs contain things like perl and gcc, those are I believe far too
big to be put entirely into cache and emulate "Real Life" quite
well...

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
