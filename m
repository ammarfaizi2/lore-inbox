Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVHCTMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVHCTMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVHCTMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:12:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:44246 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262394AbVHCTMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:12:52 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Stephen Ray <stephen@mrmighty.net>
Cc: Pavel Machek <pavel@ucw.cz>, James Bruce <bruce@andrew.cmu.edu>,
       David Weinehall <tao@acc.umu.se>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42F0FB55.9000409@mrmighty.net>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050802112529.GA7954@elf.ucw.cz> <1122991631.5490.29.camel@mindpipe>
	 <42F0FB55.9000409@mrmighty.net>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 15:12:49 -0400
Message-Id: <1123096370.9038.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 14:13 -0300, Stephen Ray wrote:
> Lee Revell wrote:
> > On Tue, 2005-08-02 at 13:25 +0200, Pavel Machek wrote:
> > 
> >>BTW I think many architectures have HZ=100 even in 2.6, so it is not
> >>as siple as "go 2.6"...
> > 
> > 
> > Does not matter.  An app that only ever worked on 2.6 + x86 will break
> > on 2.6.13.
> > 
> > Lee
> > 
> 
> But then isn't that app broken?  What if the user running it selects 
> something other than HZ=1000?

Then they changed the setting from the defaults, so they get what they
deserve.  If kernel defaults are irrelevant, the only issue is whether
or not we choose to violate the principle of least surprise for people
who run kernel.org kernels.  The technical merits of different HZ
settings are completely irrelevant.

Lee

