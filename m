Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264522AbSIVUrF>; Sun, 22 Sep 2002 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbSIVUrF>; Sun, 22 Sep 2002 16:47:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:10880 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264522AbSIVUrE>;
	Sun, 22 Sep 2002 16:47:04 -0400
Date: Sun, 22 Sep 2002 01:33:46 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Richard Henderson <rth@twiddle.net>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020922013346.A39@toy.ucw.cz>
References: <20020919124117.A22720@twiddle.net> <Pine.LNX.3.95.1020919154730.16046A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1020919154730.16046A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Sep 19, 2002 at 03:53:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It's a problem with a 'general purpose' compiler that wants to
> be "all things" to all people. If somebody made a gcc-compatible
> compiler, tuned to the ix86 characteristics, I think we could
> cut the extra instructions by at least 1/2, maybe more.

Remember pgcc? 

And btw cutting instructions by 1/2might look nice but unless you can
keep it as fast as it was, its useless.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

