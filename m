Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280792AbRKBSwi>; Fri, 2 Nov 2001 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKBSva>; Fri, 2 Nov 2001 13:51:30 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:15550 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S280781AbRKBSvL>;
	Fri, 2 Nov 2001 13:51:11 -0500
Date: Fri, 2 Nov 2001 19:51:02 +0100
From: David Weinehall <tao@acc.umu.se>
To: Sean Middleditch <elanthis@awesomeplay.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Via onboard audio
Message-ID: <20011102195102.G17407@khan.acc.umu.se>
In-Reply-To: <E15zii5-00037A-00@the-village.bc.nu> <1004724193.4883.21.camel@smiddle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1004724193.4883.21.camel@smiddle>; from elanthis@awesomeplay.com on Fri, Nov 02, 2001 at 01:03:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 01:03:13PM -0500, Sean Middleditch wrote:
> On Fri, 2001-11-02 at 13:06, Alan Cox wrote:
> > > OK, will do that.  RedHat uses your kernel trees, right?  I'll download
> > > new RPM's from rawhide if they're there (I'm in no hurry.)
> > 
> > Both Linus and -ac current trees support
> > 
> > make config
> > make rpm
> > 
> > rpm -Ivh blah...
> > 
> > then edit your lilo/grub config 8)
> 
> Hmm, good point, I forgot that was added.
> 
> I suppose I could be evil and ask when make deb support will be there for my
> more preferred Debian boxes... But I won't ask.  ~,^

Not needed.

fakeroot make-kpkg kernel_image

or similar should do the trick.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
