Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271236AbTHHG1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHHG1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:27:34 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:44691 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S271236AbTHHG1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:27:34 -0400
Date: Fri, 8 Aug 2003 08:26:39 +0200
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] 2.4.22-pre10-ac1 after resume from suspend usb not aviable
Message-ID: <20030808062639.GA22019@puettmann.net>
References: <20030805143254.GA5844@puettmann.net> <20030806055732.GC6966@kroah.com> <20030806090525.GA10564@puettmann.net> <20030806163529.GB6209@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806163529.GB6209@kroah.com>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19l0hz-0005jX-00*NIDwsEWtCKU* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 09:35:29AM -0700, Greg KH wrote:
> > > > Suspend works if radeonfb is not loaded. But after resume from suspend
> > > > all USB devices are not aviable. If I try to start the hotplug manager
> > > > new I got this Errors: 
> > > 
> > > Try unloading all usb drivers before suspending, that should work
> > > better.
> > > 
> > 
> > That can not be the solution. It's a not nice workaround.
> 
> Heh, that's the only sure way to do this reliably right now for 2.4,
> sorry.
> 
It seems in 2.6 too. I think a reboot will be faster. For me is apm -s (
suspend) so not useable with linux.  

            Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
