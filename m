Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSDDQUw>; Thu, 4 Apr 2002 11:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSDDQUn>; Thu, 4 Apr 2002 11:20:43 -0500
Received: from pool-141-154-203-50.bos.east.verizon.net ([141.154.203.50]:2688
	"EHLO book.ducksong.com") by vger.kernel.org with ESMTP
	id <S313238AbSDDQUX>; Thu, 4 Apr 2002 11:20:23 -0500
Date: Thu, 4 Apr 2002 11:21:12 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, minyard@acm.org
Subject: Re: 2.4.19-pre4-ac4 kills my gdm
Message-ID: <20020404162112.GA1171@ducksong.com>
In-Reply-To: <20020404142308.GA1177@ducksong.com> <E16t8yO-00068s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

mea culpa on this one - my problem appears to be with the only other
patch I was running - I believed I was also running it on ac3, but it
now appears that I was thinking of another box.

The other patch was corey minyard's "allow signal handler to not call
handler" patch that I was interested in seeing its impact on a
userspace project of mine. It kills gdm (at least with ac4.. maybe
others?)

thanks,
-Pat

[Alan Cox: Thu, Apr 04, 2002 at 04:16:24PM +0100]
> > X does start successfully.. but not gdm. I can go to runlevel 3 and
> > run startx without a problem (i.e. get a window manager, etc..)
> > 
> > If I boot back to 2.4.19-pre4-ac3 all is well again.
> > 
> 
> Can you do a clean build with pre4-ac4 for non athlon cpu, try that, then
> a clean built back to with athlon cpu just to verify that is the actual
> issue ?
