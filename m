Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbTLHIDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 03:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbTLHIDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 03:03:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:19119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265333AbTLHIDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 03:03:23 -0500
Date: Sun, 7 Dec 2003 23:40:21 -0800
From: Greg KH <greg@kroah.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: USB/visor oops
Message-ID: <20031208074021.GA24585@kroah.com>
References: <mailman.1070778724.26453.linux-kernel2news@redhat.com> <200312071935.hB7JZxMc015085@devserv.devel.redhat.com> <1070862306.2922.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070862306.2922.2.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 10:45:06PM -0700, Dax Kelson wrote:
> On Sun, 2003-12-07 at 12:35, Pete Zaitcev wrote:
> > > After having had my Tre600 hotsyncing working fine with RHL9 I'm trying
> > > again after upgrading to Fedora. So far all I get are oops and hangs.
> > 
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107929
> > 
> > Try 2.4.23 as Greg says and LET ME KNOW THE RESULT, please.
> 
> It works great with 2.4.23! No oops, hotsync goes.
> 
> Greg question for you. Before I always used /dev/usb/ttyUSB0 to hotsync
> against, now it that doesn't work but ttyUSB1 does. Any ideas?

Are you sure?  Hm, don't know.  I don't have a Treo600 to try it out :)
Anyway, glad to see it works in 2.4.23.

I'll go download the fedora kernel source rpm and see if they didn't
include the "oops on close" bugfix that made it into 2.4.23...

thanks,

greg k-h
