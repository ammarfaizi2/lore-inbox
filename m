Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTICXhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbTICXhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:37:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:55781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264312AbTICXg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:36:56 -0400
Date: Wed, 3 Sep 2003 16:36:03 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: USB modem no longer detected in -test4
Message-ID: <20030903233602.GA1416@kroah.com>
References: <20030903191701.GA2798@elf.ucw.cz> <20030903223936.GA7418@kroah.com> <20030903224412.GA6822@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903224412.GA6822@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 12:44:12AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > In 2.6.0-test4, USB ELSA modem no longer works. This is UHCI (on
> > > toshiba 4030cdt).
> > > 
> > > Relevant messages seem to be:
> > > 
> > > PM: Adding info for usb:1-1.2
> > > drivers/usb/class/cdc-acm.c: need inactive config#2
> > > PM: Adding info for usb:1-1.2:0
> > > drivers/usb/class/cdc-acm.c: need inactive config#2
> > 
> > And this worked just fine in 2.6.0-test3?
> 
> It worked okay in 2.5.62, and probably in many later versions, but I'm
> not sure if I specificaly tested it with -test3.

2.5.62???  You are going to have to help narrow it down a bit more :)

thanks,

greg k-h
