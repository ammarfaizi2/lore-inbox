Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbTHFQhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270763AbTHFQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:36:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:130 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270760AbTHFQfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:35:19 -0400
Date: Wed, 6 Aug 2003 09:35:29 -0700
From: Greg KH <greg@kroah.com>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] 2.4.22-pre10-ac1 after resume from suspend usb not aviable
Message-ID: <20030806163529.GB6209@kroah.com>
References: <20030805143254.GA5844@puettmann.net> <20030806055732.GC6966@kroah.com> <20030806090525.GA10564@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806090525.GA10564@puettmann.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 11:05:26AM +0200, Ruben Puettmann wrote:
> On Tue, Aug 05, 2003 at 10:57:32PM -0700, Greg KH wrote:
> > On Tue, Aug 05, 2003 at 04:32:54PM +0200, Ruben Puettmann wrote:
> > > 
> > > Suspend works if radeonfb is not loaded. But after resume from suspend
> > > all USB devices are not aviable. If I try to start the hotplug manager
> > > new I got this Errors: 
> > 
> > Try unloading all usb drivers before suspending, that should work
> > better.
> > 
> 
> That can not be the solution. It's a not nice workaround.

Heh, that's the only sure way to do this reliably right now for 2.4,
sorry.

greg k-h
