Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUABW4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUABW4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:56:38 -0500
Received: from sole.infis.univ.trieste.it ([140.105.134.1]:57287 "EHLO
	sole.infis.univ.trieste.it") by vger.kernel.org with ESMTP
	id S265673AbUABW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:56:36 -0500
Date: Fri, 2 Jan 2004 23:56:27 +0100
From: Andrea Barisani <lcars@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: does udev really require hotplug?
Message-ID: <20040102225627.GB24688@sole.infis.univ.trieste.it>
References: <20040102101051.GA12073@sole.infis.univ.trieste.it> <20040102201905.GB4992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102201905.GB4992@kroah.com>
X-GPG-Key: 0x864C9B9E
X-GPG-Fingerprint: 0A76 074A 02CD E989 CE7F  AC3F DA47 578E 864C 9B9E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 12:19:05PM -0800, Greg KH wrote:
> On Fri, Jan 02, 2004 at 11:10:51AM +0100, Andrea Barisani wrote:
> > 
> > Hi everybody and happy new year!
> > 
> > Just one simple question about a very simple matter that right now 
> > I can't figure out: does udev need hotplug package presence?
> > 
> > >From your README:
> > 
> >   If for some reason you do not install the hotplug scripts, you must tell the
> >   kernel to point the hotplug binary at wherever you install udev at.  This can
> >   be done by:
> > 	echo "/sbin/udev" > /proc/sys/kernel/hotplug
> > 
> > 
> > ...does this work properly?
> 
> It should.  Does it not for you?
> 
> > It's not clear if some features are lost by not having hotplug script
> > installed.
> 
> None of the other programs that hook off of the hotplug program will be
> available to you if you do this (automatic driver loading, firmware
> loading, devlabel, etc.)
> 
> > Also is this policy subject to changes in the near future?
> 
> What policy?  If you don't have the hotplug package installed, then you
> can still use udev.  If you have the hotplug package installed, I've
> detailed how you can still use udev.  What's the problem?  :)
> 
> thanks,
> 
> greg k-h

Ok, now it's all clear :). It wasn't so clear from the documentation (at
least for me) and since I'm not fully familiar with hotplug features I've
decided to ask ;).

Thanks a lot for your feedback

Bye


-- 
Andrea Barisani <lcars@gentoo.org>                            .*.
Gentoo Linux Infrastructure Developer                          V
                                                             (   )
GPG-Key 0x864C9B9E http://dev.gentoo.org/~lcars/pubkey.asc   (   )
    0A76 074A 02CD E989 CE7F AC3F DA47 578E 864C 9B9E        ^^_^^
