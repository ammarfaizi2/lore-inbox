Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTIXWUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTIXWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:20:48 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:49052 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261615AbTIXWUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:20:47 -0400
Date: Wed, 24 Sep 2003 18:20:46 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030924222045.GA32689@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20030921184149.GA12274@washoe.rutgers.edu> <20030922063324.GF3398@ppp0.net> <20030923050848.GA5917@washoe.rutgers.edu> <20030923094746.GA22232@ppp0.net> <20030924204846.GS11234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924204846.GS11234@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Sep 24, 2003 at 01:48:46PM -0700, Greg KH wrote:
> On Tue, Sep 23, 2003 at 11:47:46AM +0200, Jan Dittmer wrote:
> > Yaroslav Halchenko <yoh@onerussian.com> wrote on 2003-09-23 01:08:48
> > > > > 
> > > > > http://www.onerussian.com/Linux/bug.USB/
> > Greg, what is going on here? In a nutshell: Irq 9 gets disabled on boot
> > and all other devices on this irq consequently doesn't work any more.
> > Here is the oops from dmesg again:
> 
> There's no "oops" here, just a warning message.  Things worked just fine
> after this, right?
If you mean after issuing that 'warning'? no - USB doesn't work at all.

Reverse patch kinda helped, but then I started getting some weird
behaviour which might be not due to reverse patch but some other
problems...

> Did you try David Brownell's patch for this issue?
Can you please point which one exactly? I've tried to locate patch you
meant but it is too much of USB staff is happening now seems to me.

Thank you in advance

                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
