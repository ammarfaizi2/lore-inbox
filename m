Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSIMDGX>; Thu, 12 Sep 2002 23:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSIMDGX>; Thu, 12 Sep 2002 23:06:23 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:38882 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S315923AbSIMDGW>; Thu, 12 Sep 2002 23:06:22 -0400
Message-ID: <3D815763.45593F2F@bigpond.com>
Date: Fri, 13 Sep 2002 13:11:31 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and 
 agpgart
References: <3D7FF444.87980B8E@bigpond.com.suse.lists.linux.kernel> <p73ptvjpmec.fsf@oldwotan.suse.de> <20020912213201.GA9168@himi.org> <3D811B12.A6615688@bigpond.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan wrote:
> 
> Simon Fowler wrote:
> >
> > On Thu, Sep 12, 2002 at 11:50:19AM +0200, Andi Kleen wrote:
> > > Allan Duncan <allan.d@bigpond.com> writes:
> > > >
> > > > Any suggestions of how to improve the error messages around the failure point
> > > > are welcome.  Nothing is written into dmesg at the time of failure.
> > >
> > > You're booting with mem=nopentium right ? It should go away when you turn
> > > that off. I'm working on a fix. You can safely turn it off for now, the
> > > old problems that it worked around are fixed.
> > >
> > The problem goes away without mem=nopentium - I've just booted into
> > 2.4.20-pre5aa2 and fired up X.
> 
> Not in my case, at least for 2.4.20-pre4.

Errm.  Turns out I ran the same test twice, both with nopentium.

So, in summary, nopentium doesn't break 2.4.20-pre3 and earlier,
breaks 2.4.20-pre4 and later.

Thankyou all.
