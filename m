Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTIXVwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbTIXVwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:52:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:8623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261632AbTIXVu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:50:59 -0400
Date: Wed, 24 Sep 2003 13:48:46 -0700
From: Greg KH <greg@kroah.com>
To: Yaroslav Halchenko <yoh@onerussian.com>, linux-kernel@vger.kernel.org
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030924204846.GS11234@kroah.com>
References: <20030921184149.GA12274@washoe.rutgers.edu> <20030922063324.GF3398@ppp0.net> <20030923050848.GA5917@washoe.rutgers.edu> <20030923094746.GA22232@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923094746.GA22232@ppp0.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 11:47:46AM +0200, Jan Dittmer wrote:
> Yaroslav Halchenko <yoh@onerussian.com> wrote on 2003-09-23 01:08:48
> > Thanx - reversing all "improvements"  done in -bk5 seems to help
> > - usb works :-))
> > 
> > --Yarik
> > 
> > On Mon, Sep 22, 2003 at 08:33:24AM +0200, Jan Dittmer wrote:
> > > Yaroslav Halchenko <kernel@onerussian.com> wrote on 2003-09-21 14:41:49
> > > > Dear Gurus,
> > > > 
> > > > Since one of the bk versions in -test4- USB problem persist. On boot I'm
> > > > getting next dump. More information about my system and configuration is at
> > > > 
> > > > http://www.onerussian.com/Linux/bug.USB/
> > > > 
> > > > Please help to get rid of the problem cause USB doesn't work now for me :-(
> > > 
> > > Try reverting the following patch, taken from the bk4-bk5 incremental
> > > diff (Apply with patch -p1 -R). This fixed it for me.
> > > 
> > >    Jan
> > > 
> 
> Greg, what is going on here? In a nutshell: Irq 9 gets disabled on boot
> and all other devices on this irq consequently doesn't work any more.
> Here is the oops from dmesg again:

There's no "oops" here, just a warning message.  Things worked just fine
after this, right?

Did you try David Brownell's patch for this issue?

thanks,

greg k-h
